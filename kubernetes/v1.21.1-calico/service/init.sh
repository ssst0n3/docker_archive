#!/bin/bash

log() {
  echo "[docker-archive/kubernetes/v1.20.2-calico] $1" >> /dev/kmsg
}

log "wait pods ready"
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "install network addon"

# do not build on latest kernel
# ipset v7.1: Kernel and userspace incompatible: settype hash:ip with revision 5 not supported by userspace.

# https://docs.tigera.io/archive/v3.19/getting-started/kubernetes/requirements#supported-versions
# https://docs.tigera.io/archive/v3.19/getting-started/kubernetes/quickstart#install-calico
kubectl create -f https://docs.projectcalico.org/archive/v3.19/manifests/tigera-operator.yaml >/dev/kmsg 2>&1
kubectl create -f https://docs.projectcalico.org/archive/v3.19/manifests/custom-resources.yaml >/dev/kmsg 2>&1

log "Waiting for all pods ready"
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "remove unused containers"
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
