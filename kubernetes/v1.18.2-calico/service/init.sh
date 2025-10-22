#!/bin/bash

cp /trick /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots -r
systemctl enable --now containerd
systemctl enable --now kubelet
# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# install network addon
# https://docs.tigera.io/archive/v3.18/getting-started/kubernetes/requirements#kernel-dependencies
kubectl create -f https://docs.projectcalico.org/archive/v3.16/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/archive/v3.16/manifests/custom-resources.yaml

# wait pods ready
echo "Waiting for all pods ready" >> /dev/kmsg
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# remove unused containers
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
