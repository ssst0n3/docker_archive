#!/bin/bash
docker build -t $1 .
# TODO: create network
# TODO: use --ip=10.0.2.15
docker run -tid --privileged --name $1-ctr --hostname=kind-control-plane --entrypoint=/sbin/init $1
docker exec -it --privileged $1-ctr /bin/bash
# sed -i '/exit 1/d' /kind/bin/create-kubelet-cgroup-v2.sh
# systemctl enable --now containerd
# systemctl enable --now kubelet
# kubeadm init --config /kind/kubeadm.conf

# mkdir -p /root/.kube
# cp /etc/kubernetes/admin.conf /root/.kube/config
# kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/tigera-operator.yaml
# curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/custom-resources.yaml -O
# kubectl create -f custom-resources.yaml
# systemctl exit 0
docker commit $1-ctr $1