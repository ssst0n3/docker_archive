#!/bin/bash

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# install network addon
# https://docs.tigera.io/calico/3.30/getting-started/kubernetes/requirements#kubernetes-requirements
helm repo add projectcalico https://docs.tigera.io/calico/charts >>/dev/kmsg 2>&1
kubectl create namespace tigera-operator >>/dev/kmsg 2>&1
helm install calico projectcalico/tigera-operator --version v3.30.1 --namespace tigera-operator >>/dev/kmsg 2>&1

# wait pods ready
echo "Waiting for all pods ready" >> /dev/kmsg
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# remove unused containers
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
