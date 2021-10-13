#!/bin/bash
set -ex
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
# install docker
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce-20.10.9 docker-ce-cli-20.10.9 containerd.io-1.4.11
systemctl enable docker
systemctl start docker
# cgroup driver
cat <<EOF | tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

systemctl enable docker
systemctl daemon-reload
systemctl restart docker
# install k8s
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet-1.22.2 kubeadm-1.22.2 kubectl-1.22.2 --disableexcludes=kubernetes

systemctl enable --now kubelet
# init cluster
kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p /root/.kube
cp /etc/kubernetes/admin.conf /root/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl create -f https://docs.projectcalico.org/archive/v3.20/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/archive/v3.20/manifests/custom-resources.yaml
while true
do
    sleep 5
    if [ $(kubectl get pods -A | wc -l) = 13 ]; then break; fi
done
while true
do
    sleep 5
    if [ $(kubectl get pods -A |grep -v Running | wc -l) = 1 ]; then break; fi
done
kubectl taint nodes --all node-role.kubernetes.io/master-
