# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_containerd-v2.0.3_v0.2.0 AS static

# ipv4 forwarding
RUN echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/k8s.conf 
    # not work in dockerfile
    # sysctl --system

# cgroup driver: systemd is the default

# install CNI plugins
ADD https://github.com/containernetworking/plugins/releases/download/v1.6.2/cni-plugins-linux-amd64-v1.6.2.tgz /tmp/cni-plugins.tgz
RUN mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin /tmp/cni-plugins.tgz && \
    rm /tmp/cni-plugins.tgz

# install kubeadm, kubelet, kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gpg && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubelet=1.32.3-1.1 kubeadm=1.32.3-1.1 kubectl=1.32.3-1.1 && \
    apt-mark hold kubelet kubeadm kubectl && \
    apt-get install -y kmod && \
    rm -rf /var/lib/apt/lists/*

FROM static AS kubeadm_init

# configure snapshotter
## install fuse-overlayfs
RUN apt update && \
    apt install -y fuse-overlayfs && \
    rm -rf /var/lib/apt/lists/*
## install containerd-fuse-overlayfs
ADD https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v2.1.2/containerd-fuse-overlayfs-2.1.2-linux-amd64.tar.gz /tmp/fuse-overlayfs-snapshotter.tar.gz
RUN tar -C /usr/local/bin -xzvf /tmp/fuse-overlayfs-snapshotter.tar.gz && \
    rm /tmp/fuse-overlayfs-snapshotter.tar.gz
# TOOD: copy from local
COPY --from=kindest/node:v1.32.3 /etc/systemd/system/containerd-fuse-overlayfs.service /etc/systemd/system/containerd-fuse-overlayfs.service
RUN systemctl enable containerd-fuse-overlayfs.service
## setup containerd config
RUN mkdir -p /etc/containerd && \
    containerd config default > /etc/containerd/config.toml && \
    sed -i "s/snapshotter = 'overlayfs'/snapshotter = 'fuse-overlayfs'/" /etc/containerd/config.toml
RUN cat >> /etc/containerd/config.toml <<EOF
[proxy_plugins]
[proxy_plugins."fuse-overlayfs"]
    type = "snapshot"
    address = "/run/containerd-fuse-overlayfs.sock"
EOF

# kubeadm init
COPY --from=kindest/node:v1.32.3 /kind/ /kind/
COPY --from=kindest/node:v1.32.3 /etc/systemd/system/kubelet.service.d/11-kind.conf /etc/systemd/system/kubelet.service.d/11-kind.conf
COPY service/kubeadm.conf /kind/
COPY service/init.sh /
COPY service/init.service /usr/lib/systemd/system/
COPY service/setup-hosts.service /usr/lib/systemd/system/

RUN systemctl enable kubelet.service && \
    systemctl enable init.service
ENV KUBECONFIG=/etc/kubernetes/admin.conf
RUN sed -i '/exit 1/d' /kind/bin/create-kubelet-cgroup-v2.sh
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

# finish
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh && \
    systemctl enable setup-hosts.service

FROM scratch AS release
COPY --from=kubeadm_init / /