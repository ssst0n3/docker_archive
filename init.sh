#!/bin/bash
set -ex
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
# install docker
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce=17.03.3~ce-0~ubuntu-xenial
# install kube
apt-get update && apt-get install -y apt-transport-https ca-certificates curl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update && apt-get install -y kubernetes-cni=0.6.0-00 kubelet=1.9.3-00 kubeadm=1.9.3-00 kubectl=1.9.3-00  
# init cluster
kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=1.9.3
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config
KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/v0.9.1/Documentation/kube-flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/master-
while true
do
    sleep 1
    if [ $(kubectl get pods -n kube-system | wc -l) = 8 ]; then break; fi
done
do
    sleep 1
    if [ $(kubectl get pods -n kube-system |grep -v Running | wc -l) = 1 ]; then break; fi
done
# check
cat /etc/shadow
kubectl get pods -n kube-system
