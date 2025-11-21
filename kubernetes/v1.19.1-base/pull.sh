#!/bin/bash
set -x
containerd &
sleep 5
kubeadm config images list --kubernetes-version v${VERSION_K8S} | xargs -n 1 ctr -n k8s.io images pull
crictl images