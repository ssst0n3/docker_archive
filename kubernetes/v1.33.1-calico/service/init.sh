#!/bin/bash

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# install network addon
# https://docs.tigera.io/calico/3.30/getting-started/kubernetes/requirements#kubernetes-requirements
echo "Applying Tigera Operator manifest..." >> /dev/kmsg
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.1/manifests/tigera-operator.yaml >>/dev/kmsg 2>&1
echo "Waiting for Custom Resource Definitions (CRDs) to be established..." >> /dev/kmsg
until kubectl wait --for condition=established crd/installations.operator.tigera.io --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1 
echo "Waiting for Tigera Operator deployment to become available..." >> /dev/kmsg
until kubectl wait deployment -n tigera-operator tigera-operator --for=condition=available --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1
echo "Applying Calico custom resource configuration..." >> /dev/kmsg
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.1/manifests/custom-resources.yaml >>/dev/kmsg 2>&1
echo "Calico installation process initiated successfully." >> /dev/kmsg

# wait pods ready
echo "Waiting for all pods ready" >> /dev/kmsg
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# remove unused containers
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
