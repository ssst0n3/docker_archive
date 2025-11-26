#!/bin/bash

log() {
  echo "[docker-archive/kubernetes/v1.26.0-calico] $1" >> /dev/kmsg
}

log "wait pods ready"
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "install network addon"
# https://archive-os-3-25.netlify.app/calico/3.25/getting-started/kubernetes/requirements/#kubernetes-requirements
# https://archive-os-3-25.netlify.app/calico/3.25/getting-started/kubernetes/quickstart#install-calico
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.2/manifests/tigera-operator.yaml >>/dev/kmsg 2>&1
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.2/manifests/custom-resources.yaml >>/dev/kmsg 2>&1

log "Waiting for all pods ready"
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

log "remove unused containers"
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
