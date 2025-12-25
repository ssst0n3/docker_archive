#!/bin/bash

log() {
  echo "[docker-archive/kubernetes/v1.24.0] $1" >> /dev/kmsg
}

set_hostname() {
  log "Setting hostname"
  hostnamectl set-hostname kubernetes-1-24-0
  log "Hostname set"
}

init_kubernetes() {
  log "kubeadm init"
  kubeadm init --skip-phases=preflight --config=/kind/kubeadm.conf --skip-token-print --v=6 > /dev/kmsg 2>&1
  log "kubeadm init completed"
}

remove_master_taint() {
  log "Removing master taint"
  kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master- > /dev/kmsg 2>&1
  log "Master taint removed"
}

wait_kube_system_pods_created() {
  log "Waiting for kube-system pods to be created..."
  local MAX_WAIT_TIME=300
  local WAIT_INTERVAL=5
  local elapsed=0
  
  while true; do
    local POD_COUNT=$(kubectl get pods -n kube-system --no-headers 2>/dev/null | wc -l || true)
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
}

wait_kube_system_pods_ready() {
  log "Waiting for kube-system pods to be ready"
  until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do 
    sleep 1
  done >>/dev/kmsg 2>&1
  log "kube-system pods are ready"
}

sync_data() {
  log "Syncing data to prevent data loss"
  sync
  log "Data synced"
}

graceful_exit() {
  log "Gracefully exiting systemd"
  systemctl exit 0
}

set_hostname
init_kubernetes
remove_master_taint
wait_kube_system_pods_created
wait_kube_system_pods_ready
sync_data
graceful_exit
