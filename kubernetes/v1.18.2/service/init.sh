#!/bin/bash

hostnamectl set-hostname kubernetes-1-18-2
# kubeadm init
kubeadm init --skip-phases=preflight --config=/kind/kubeadm.conf --skip-token-print --v=6 > /dev/kmsg 2>&1
# taint
kubectl taint nodes --all node-role.kubernetes.io/master- > /dev/kmsg 2>&1

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
