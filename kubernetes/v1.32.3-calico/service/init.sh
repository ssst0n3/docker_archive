#!/bin/bash

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# install network addon
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.3/manifests/tigera-operator.yaml >>/dev/kmsg 2>&1
curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.3/manifests/custom-resources.yaml -O
kubectl create -f custom-resources.yaml >>/dev/kmsg 2>&1

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
