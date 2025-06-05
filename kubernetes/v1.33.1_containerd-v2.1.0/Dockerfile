# syntax=docker/dockerfile:1-labs

# k8s version: https://github.com/kubernetes-sigs/kind/blob/v0.28.0/pkg/apis/config/defaults/image.go#L21
ARG VERSION_K8S=1.33.1
ARG VERSION_K8S_MAIN=1.33
ARG VERSION_KIND=0.28.0
# https://github.com/kubernetes-sigs/kind/blob/v0.28.0/images/base/Dockerfile#L125
ARG VERSION_CONTAINERD=2.1.0
# https://github.com/kubernetes-sigs/kind/blob/v0.28.0/images/base/Dockerfile#L171
ARG VERSION_CNI_PLUGINS=1.7.1
# https://github.com/kubernetes-sigs/kind/blob/v0.28.0/images/base/Dockerfile#L192
ARG VERSION_CONTAINERD_FUSE_OVERLAYFS=2.1.0
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI_PLUGINS}/cni-plugins-linux-amd64-v${VERSION_CNI_PLUGINS}.tgz
ARG URL_ARTIFACT_KIND=https://raw.githubusercontent.com/kubernetes-sigs/kind/refs/tags/v${VERSION_KIND}
ARG URL_ARTIFACT_FUSE_OVERLAYFS=https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v${VERSION_CONTAINERD_FUSE_OVERLAYFS}/containerd-fuse-overlayfs-${VERSION_CONTAINERD_FUSE_OVERLAYFS}-linux-amd64.tar.gz

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS prerequisite
ARG URL_ARTIFACT_CNI
# ipv4 forwarding
RUN echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/k8s.conf 
    # not work in dockerfile
    # sysctl --system
# cgroup driver: systemd is the default

FROM prerequisite AS install_cni
# install CNI plugins
ADD ${URL_ARTIFACT_CNI} /tmp/cni-plugins.tgz
RUN mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin /tmp/cni-plugins.tgz && \
    rm /tmp/cni-plugins.tgz

FROM install_cni AS install_kube
ARG VERSION_K8S
ARG VERSION_K8S_MAIN
# install kubeadm, kubelet, kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gpg && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v${VERSION_K8S_MAIN}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${VERSION_K8S_MAIN}/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubelet=${VERSION_K8S}-1.1 kubeadm=${VERSION_K8S}-1.1 kubectl=${VERSION_K8S}-1.1 && \
    apt-mark hold kubelet kubeadm kubectl && \
    apt-get install -y kmod && \
    rm -rf /var/lib/apt/lists/*

FROM install_kube AS install_fuse_overlayfs
ARG ARG URL_ARTIFACT_FUSE_OVERLAYFS
ARG URL_ARTIFACT_KIND
# configure snapshotter
## install fuse-overlayfs
RUN apt update && \
    apt install -y fuse-overlayfs && \
    rm -rf /var/lib/apt/lists/*
## install containerd-fuse-overlayfs
ADD ${URL_ARTIFACT_FUSE_OVERLAYFS} /tmp/fuse-overlayfs-snapshotter.tar.gz
RUN tar -C /usr/local/bin -xzvf /tmp/fuse-overlayfs-snapshotter.tar.gz && \
    rm /tmp/fuse-overlayfs-snapshotter.tar.gz
ADD ${URL_ARTIFACT_KIND}/images/base/files/etc/systemd/system/containerd-fuse-overlayfs.service /etc/systemd/system/containerd-fuse-overlayfs.service
RUN systemctl enable containerd-fuse-overlayfs.service
## setup containerd config
# https://github.com/kubernetes-sigs/kind/blob/v0.28.0/images/base/files/usr/local/bin/entrypoint#L142
RUN mkdir -p /etc/containerd && \
    containerd config default > /etc/containerd/config.toml && \
    sed -i "s/snapshotter = 'overlayfs'/snapshotter = 'fuse-overlayfs'/" /etc/containerd/config.toml
# unpack_config: https://github.com/containerd/containerd/issues/11606#issuecomment-2927814182
RUN cat >> /etc/containerd/config.toml <<EOF
[proxy_plugins]
  [proxy_plugins."fuse-overlayfs"]
    type = "snapshot"
    address = "/run/containerd-fuse-overlayfs.sock"
[[plugins."io.containerd.transfer.v1.local".unpack_config]]
  platform = "linux/amd64"
  snapshotter = "fuse-overlayfs"
EOF

FROM install_fuse_overlayfs AS kube_init
ARG URL_ARTIFACT_KIND
# kubeadm init
ADD ${URL_ARTIFACT_KIND}/images/base/files/etc/systemd/system/kubelet.service.d/11-kind.conf /etc/systemd/system/kubelet.service.d/11-kind.conf
ADD --chmod=755 ${URL_ARTIFACT_KIND}/images/base/files/kind/bin/create-kubelet-cgroup-v2.sh /kind/bin/create-kubelet-cgroup-v2.sh
RUN cat /etc/systemd/system/kubelet.service.d/11-kind.conf
COPY service/kubeadm.conf /kind/
COPY service/init.sh /
COPY service/init.service /usr/lib/systemd/system/
COPY service/setup-hosts.service /usr/lib/systemd/system/
RUN systemctl enable kubelet.service && \
    systemctl enable init.service
ENV KUBECONFIG=/etc/kubernetes/admin.conf
RUN sed -i '/exit 1/d' /kind/bin/create-kubelet-cgroup-v2.sh
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]

FROM kube_init AS final
RUN mkdir -p /root/.kube && \
    cp /etc/kubernetes/admin.conf /root/.kube/config && \
    rm /usr/lib/systemd/system/init.service /init.sh && \
    systemctl enable setup-hosts.service
