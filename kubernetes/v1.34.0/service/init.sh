#!/bin/bash

hostnamectl set-hostname kubernetes-1-34-0
IP=$(ip -4 addr show eth0 | grep -o "inet [0-9.]*" | cut -d" " -f2) && sed -i "s/172.17.0.2/$IP/g" /kind/kubeadm.conf

# kubeadm init
/usr/bin/kubeadm init --config=/kind/kubeadm.conf --skip-token-print --v=6 > /dev/kmsg
# taint
kubectl --kubeconfig=/etc/kubernetes/admin.conf taint nodes --all node-role.kubernetes.io/control-plane- > /dev/kmsg

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
