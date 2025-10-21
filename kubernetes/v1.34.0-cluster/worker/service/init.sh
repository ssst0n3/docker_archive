#!/bin/bash
log() {
  echo "[worker] $1" >> /dev/kmsg
}

log "kubeadm join"
kubeadm join 10.0.2.16:6443 --skip-phases=preflight \
  --token abcdef.0123456789abcdef \
  --discovery-token-ca-cert-hash sha256:6701bebc0a43e3b8a0d8176021602b4fc0ac019976f086e090ce92ea6110f438 >> /dev/kmsg
# kubeadm join --config /kind/kubeadm.conf

log "wait pods ready"
log "Waiting for all pods ready" >> /dev/kmsg
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1


log "remove unused containers"
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

log "prevent data lost"
sync

log "gracefully exit"
systemctl exit 0
