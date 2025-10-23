#!/bin/bash

log() {
  echo "[docker-archive/kubernetes/v1.18.2-calico] $1" >> /dev/kmsg
}

log "wait pods ready"
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "install network addon"
# https://docs.tigera.io/archive/v3.18/getting-started/kubernetes/requirements#kernel-dependencies
kubectl create -f https://docs.projectcalico.org/archive/v3.16/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/archive/v3.16/manifests/custom-resources.yaml

log "Waiting for all pods ready"
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "remove unused containers"
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
