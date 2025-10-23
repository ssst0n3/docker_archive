#!/bin/bash
log() {
  echo "[docker-archive/kubernetes/v1.18.2-cluster/worker] $1" >> /dev/kmsg
}

# fix kube-proxy(privileged): `failed to write "a *:* rwm" to devices.allow: operation not permitted`
log "fix cgroups"
umount /sys/fs/cgroup/devices
mount -t cgroup -o devices none /sys/fs/cgroup/devices

log "kubeadm join"
kubeadm join 10.0.2.16:6443 --skip-phases=preflight \
  --token abcdef.0123456789abcdef \
  --discovery-token-ca-cert-hash sha256:46f6dfd51994a2c95cf7159ae4c2c4e86229a95533819c62d71c755017e3e537 >> /dev/kmsg

log "Waiting for all pods ready"
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "remove unused containers"
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

log "prevent data lost"
sync

log "gracefully exit"
systemctl exit 0
