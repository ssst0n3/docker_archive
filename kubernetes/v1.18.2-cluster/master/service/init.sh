#!/bin/bash

log() {
  echo "[docker-archive/kubernetes/v1.18.2-cluster/master] $1" >> /dev/kmsg
}

# fix kube-proxy(privileged): `failed to write "a *:* rwm" to devices.allow: operation not permitted`
log "fix cgroups"
umount /sys/fs/cgroup/devices
mount -t cgroup -o devices none /sys/fs/cgroup/devices

log "start kubelet"
systemctl enable --now kubelet

log "wait pods ready"
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "Waiting for at least one worker node to become Ready."
until [ "$(kubectl get nodes -l '!node-role.kubernetes.io/master' --no-headers 2>/dev/null | grep -c ' Ready ' || true)" -ge 1 ]; do
  sleep 3
done

log "Waiting for all pods ready"
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "remove unused containers"
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

log "prevent data lost"
sync

log "gracefully exit"
systemctl exit 0
