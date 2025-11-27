#!/bin/bash

log() {
  echo "[docker-archive/kubernetes/v1.25.0] $1" >> /dev/kmsg
}

hostnamectl set-hostname kubernetes-1-25-0

log "kubeadm init"
kubeadm init --skip-phases=preflight --config=/kind/kubeadm.conf --skip-token-print --v=6 > /dev/kmsg 2>&1
log "taint"
kubectl taint nodes --all node-role.kubernetes.io/control-plane- > /dev/kmsg 2>&1

log "Waiting for kube-system pods to be created..."
MAX_WAIT_TIME=300
WAIT_INTERVAL=5

elapsed=0
while true; do
  POD_COUNT=$(kubectl get pods -n kube-system --no-headers 2>/dev/null | wc -l || true)
  if [ "$POD_COUNT" -ge 7 ]; then
    log "Detected ${POD_COUNT} kube-system pods created."
    break
  fi

  if (( elapsed >= MAX_WAIT_TIME )); then
    log "Timeout waiting for kube-system pods to be created."
    break
  fi

  sleep $WAIT_INTERVAL
  ((elapsed+=WAIT_INTERVAL))
done

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
