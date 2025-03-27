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

FROM static AS kubeadm_init

# handle network

# configure snapshotter
RUN mkdir -p /etc/containerd && \
    containerd config default > /etc/containerd/config.toml && \
    sed -i "s/snapshotter = 'overlayfs'/snapshotter = 'native'/" /etc/containerd/config.toml

# kubeadm init
COPY --from=kindest/node:v1.32.2 /kind/ /kind/
COPY --from=kindest/node:v1.32.2 /etc/systemd/system/kubelet.service.d/11-kind.conf /etc/systemd/system/kubelet.service.d/11-kind.conf
# COPY --from=kindest/node:v1.32.2 /kind/manifests/default-cni.yaml /kind/manifests/default-cni.yaml
COPY service/kubeadm.conf /kind/
COPY service/kubeadm-init.sh /
COPY service/kubeadm-init.service /usr/lib/systemd/system/
COPY service/setup-hosts.service /usr/lib/systemd/system/

RUN systemctl enable kubelet.service && \
    systemctl enable kubeadm-init.service
ENV KUBECONFIG=/etc/kubernetes/admin.conf
RUN sed -i '/exit 1/d' /kind/bin/create-kubelet-cgroup-v2.sh
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

# finish
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/kubeadm-init.service /kubeadm-init.sh && \
    systemctl enable setup-hosts.service