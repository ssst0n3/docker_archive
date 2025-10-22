ARG VERSION_K8S=1.18.2
ARG VERSION_K8S_MAIN=1.18
# https://github.com/kubernetes/website/blob/release-1.18/content/en/docs/setup/production-environment/tools/kubeadm/install-kubeadm.md?plain=1#L254
ARG VERSION_K8S_RELEASE=0.2.7
# the first version support containerd-fuse-overlayfs.service
ARG VERSION_KIND=0.12.0
# https://github.com/kubernetes-sigs/kind/blob/v0.8.1/images/base/Dockerfile#L26
ARG VERSION_CONTAINERD=1.3.3
# https://github.com/kubernetes-sigs/kind/blob/v0.8.1/images/base/Dockerfile#L28
ARG VERSION_CNI_PLUGINS=0.8.5
# https://github.com/kubernetes-sigs/kind/blob/v0.12.0/images/base/Dockerfile#L62
ARG VERSION_CONTAINERD_FUSE_OVERLAYFS=1.0.4
# https://helm.sh/docs/topics/version_skew/
ARG VERSION_HELM=3.2.4
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
ARG VERSION_K8S_RELEASE
RUN apt update && \
    apt install -y curl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
# install kubeadm, kubelet, kubectl
# https://github.com/kubernetes/website/blob/release-1.18/content/en/docs/setup/production-environment/tools/kubeadm/install-kubeadm.md
# https://kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/#where-can-i-get-packages-for-kubernetes-versions-prior-to-v1-24-0
RUN set -ex && \
    cd /usr/bin && \
    curl -L --remote-name-all https://dl.k8s.io/release/${VERSION_K8S}/bin/linux/amd64/{kubeadm,kubelet,kubectl} && \
    chmod +x kubeadm kubelet kubectl && \
    curl -fL --show-error -o /etc/systemd/system/kubelet.service \
        "https://raw.githubusercontent.com/kubernetes/release/v${VERSION_K8S_RELEASE}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service" && \
    mkdir -p /etc/systemd/system/kubelet.service.d && \
    curl -fL --show-error -o /etc/systemd/system/kubelet.service.d/10-kubeadm.conf \
        "https://raw.githubusercontent.com/kubernetes/release/v${VERSION_K8S_RELEASE}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf"

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
