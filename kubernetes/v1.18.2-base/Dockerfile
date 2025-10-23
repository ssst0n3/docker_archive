# syntax=docker/dockerfile:1-labs
ARG VERSION_K8S=1.18.2
ARG VERSION_K8S_MAIN=1.18
# https://github.com/kubernetes/website/blob/release-1.18/content/en/docs/setup/production-environment/tools/kubeadm/install-kubeadm.md?plain=1#L254
ARG VERSION_K8S_RELEASE=0.2.7
# https://github.com/kubernetes-sigs/kind/blob/v0.8.1/images/base/Dockerfile#L26
ARG VERSION_CONTAINERD=1.3.3
# https://github.com/kubernetes-sigs/kind/blob/v0.8.1/images/base/Dockerfile#L28
ARG VERSION_CNI_PLUGINS=0.8.5
# https://github.com/kubernetes-sigs/kind/blob/v0.8.1/images/base/Dockerfile#L30
ARG VERSION_CRICTL=1.18.0
# https://helm.sh/docs/topics/version_skew/
ARG VERSION_HELM=3.2.4
ARG VERSION_IMAGE=0.1.0
# the kubelet.service relies on '/usr/bin/kubelet'
ARG DIR_BIN=/usr/bin
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI_PLUGINS}/cni-plugins-linux-amd64-v${VERSION_CNI_PLUGINS}.tgz
ARG URL_ARTIFACT_HELM=https://get.helm.sh/helm-v${VERSION_HELM}-linux-amd64.tar.gz
ARG URL_ARTIFACT_K8S_BIN=https://dl.k8s.io/release/v${VERSION_K8S}/bin/linux/amd64
ARG URL_ARTIFACT_K8S_RELEASE=https://raw.githubusercontent.com/kubernetes/release/v${VERSION_K8S_RELEASE}
ARG URL_ARTIFACT_CRICTL=https://github.com/kubernetes-sigs/cri-tools/releases/download/v${VERSION_CRICTL}/crictl-v${VERSION_CRICTL}-linux-amd64.tar.gz

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS prerequisite
ARG URL_ARTIFACT_CNI
RUN apt update && \
    apt install -y \
        curl \
        iproute2 \
        iptables && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
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

FROM install_cni AS install_crictl
ARG URL_ARTIFACT_CRICTL
ARG DIR_BIN
RUN curl -L ${URL_ARTIFACT_CRICTL} | tar -C ${DIR_BIN} -xz && \
    echo 'runtime-endpoint: unix:///var/run/containerd/containerd.sock' > /etc/crictl.yaml

FROM install_crictl AS install_kube
ARG URL_ARTIFACT_K8S_BIN
ARG URL_ARTIFACT_K8S_RELEASE
ARG DIR_BIN
# install kubeadm, kubelet, kubectl
# https://github.com/kubernetes/website/blob/release-1.18/content/en/docs/setup/production-environment/tools/kubeadm/install-kubeadm.md#installing-kubeadm-kubelet-and-kubectl
# https://kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/#where-can-i-get-packages-for-kubernetes-versions-prior-to-v1-24-0
RUN set -ex && \
    cd ${DIR_BIN} && \
    curl -L --remote-name-all ${URL_ARTIFACT_K8S_BIN}/{kubeadm,kubelet,kubectl} && \
    chmod +x kubeadm kubelet kubectl && \
    curl -fL --show-error -o /etc/systemd/system/kubelet.service \
        "${URL_ARTIFACT_K8S_RELEASE}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service" && \
    mkdir -p /etc/systemd/system/kubelet.service.d && \
    curl -fL --show-error -o /etc/systemd/system/kubelet.service.d/10-kubeadm.conf \
        "${URL_ARTIFACT_K8S_RELEASE}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf"

FROM install_kube AS preflight
ARG VERSION_K8S
COPY --chmod=755 pull.sh /tmp/
RUN --security=insecure /tmp/pull.sh
