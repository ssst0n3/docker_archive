# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_containerd-v2.0.2_v0.1.0 AS static

# ipv4 forwarding
RUN echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/k8s.conf 
    # not work in dockerfile
    # sysctl --system

# cgroup driver: systemd is the default

# install CNI plugins
ADD https://github.com/containernetworking/plugins/releases/download/v1.6.2/cni-plugins-linux-amd64-v1.6.2.tgz /tmp/cni-plugins.tgz
RUN mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin /tmp/cni-plugins.tgz

# install kubeadm, kubelet, kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gpg && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubelet=1.32.2-1.1 kubeadm=1.32.2-1.1 kubectl=1.32.2-1.1 && \
    apt-mark hold kubelet kubeadm kubectl && \
    apt-get install -y kmod

FROM static AS preflight
# pull kubeadm image
RUN --security=insecure containerd & \
    containerd & \
    sleep 5 && \
    kubeadm config images list --kubernetes-version v1.32.2 | xargs -n 1 ctr -n k8s.io images pull && \
    crictl images

FROM preflight AS kubeadm_init
# kubeadm init
RUN --security=insecure containerd & \
    containerd & \
    sleep 5 && \
    kubeadm init --v=5

# # create cluster
# RUN sh -c 'containerd &' && \
#     sleep 5 && \
#     kubeadm init --pod-network-cidr=192.168.0.0/16 --kubernetes-version=1.32.2 && \
#     mkdir -p /root/.kube && \
#     cp /etc/kubernetes/admin.conf /root/.kube/config

# ENV KUBECONFIG=/etc/kubernetes/admin.conf

# RUN kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# CMD []