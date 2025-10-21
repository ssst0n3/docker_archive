# syntax=docker/dockerfile:1-labs

# k8s version: https://github.com/kubernetes-sigs/kind/blob/v0.30.0/pkg/apis/config/defaults/image.go#L21
ARG VERSION_K8S=1.34.0
ARG VERSION_K8S_MAIN=1.34
ARG VERSION_KIND=0.30.0
# https://github.com/kubernetes-sigs/kind/blob/v0.30.0/images/base/Dockerfile#L125
ARG VERSION_CONTAINERD=2.1.4
# https://github.com/kubernetes-sigs/kind/blob/v0.30.0/images/base/Dockerfile#L171
ARG VERSION_CNI_PLUGINS=1.7.1
# https://github.com/kubernetes-sigs/kind/blob/v0.30.0/images/base/Dockerfile#L192
ARG VERSION_CONTAINERD_FUSE_OVERLAYFS=2.1.6
# https://helm.sh/docs/topics/version_skew/
ARG VERSION_HELM=3.19.0
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI_PLUGINS}/cni-plugins-linux-amd64-v${VERSION_CNI_PLUGINS}.tgz
ARG URL_ARTIFACT_KIND=https://raw.githubusercontent.com/kubernetes-sigs/kind/refs/tags/v${VERSION_KIND}
ARG URL_ARTIFACT_FUSE_OVERLAYFS=https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v${VERSION_CONTAINERD_FUSE_OVERLAYFS}/containerd-fuse-overlayfs-${VERSION_CONTAINERD_FUSE_OVERLAYFS}-linux-amd64.tar.gz
ARG URL_ARTIFACT_HELM=https://get.helm.sh/helm-v${VERSION_HELM}-linux-amd64.tar.gz

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS prerequisite
ARG URL_ARTIFACT_CNI
# ipv4 forwarding
RUN echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/k8s.conf 
    # not work in dockerfile
    # sysctl --system
# cgroup driver: systemd is the default

FROM prerequisite AS install_helm
ARG URL_ARTIFACT_HELM
ADD ${URL_ARTIFACT_HELM} /tmp/helm.tar.gz
RUN tar -C /tmp -xzvf /tmp/helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64 /tmp/helm.tar.gz

FROM install_helm AS install_cni
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
