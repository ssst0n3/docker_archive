# syntax=docker/dockerfile:1-labs
ARG VERSION_K8S=1.33.3
# https://github.com/kubernetes/website/blob/release-1.33/content/en/docs/setup/production-environment/tools/kubeadm/install-kubeadm.md?plain=1#L363
ARG VERSION_K8S_RELEASE=0.16.2
# kubespray introduced containerd v2.1.3
# https://github.com/kubernetes-sigs/kubespray/commit/72518b4497968a17f6ed310eb10591b66aadeabb
# the latest kubelet and kubectl in kubespray are v1.33.3
# https://github.com/kubernetes-sigs/kubespray/blob/72518b4497968a17f6ed310eb10591b66aadeabb/roles/kubespray_defaults/vars/main/checksums.yml#L1120
ARG VERSION_CONTAINERD=2.1.3
# https://github.com/kubernetes-sigs/kubespray/blob/72518b4497968a17f6ed310eb10591b66aadeabb/roles/kubespray_defaults/vars/main/checksums.yml#L410
ARG VERSION_CNI_PLUGINS=1.4.1
# https://github.com/kubernetes-sigs/kubespray/blob/72518b4497968a17f6ed310eb10591b66aadeabb/roles/kubespray_defaults/vars/main/checksums.yml#L9
ARG VERSION_CRICTL=1.33.0
# https://github.com/kubernetes-sigs/kubespray/blob/72518b4497968a17f6ed310eb10591b66aadeabb/roles/kubespray_defaults/vars/main/checksums.yml#L613
ARG VERSION_HELM=3.18.4
# https://github.com/containerd/nerdctl/blob/v2.1.3/Dockerfile#L20
ARG VERSION_NERDCTL=2.1.3
# https://github.com/containerd/nerdctl/blob/v2.1.3/Dockerfile#L25
ARG VERSION_BUILDKIT=0.23.2
ARG VERSION_IMAGE=0.1.0
# the kubelet.service relies on '/usr/bin/kubelet'
ARG DIR_BIN=/usr/bin
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI_PLUGINS}/cni-plugins-linux-amd64-v${VERSION_CNI_PLUGINS}.tgz
ARG URL_ARTIFACT_HELM=https://get.helm.sh/helm-v${VERSION_HELM}-linux-amd64.tar.gz
ARG URL_ARTIFACT_K8S_BIN=https://dl.k8s.io/release/v${VERSION_K8S}/bin/linux/amd64
ARG URL_ARTIFACT_K8S_RELEASE=https://raw.githubusercontent.com/kubernetes/release/v${VERSION_K8S_RELEASE}
ARG URL_ARTIFACT_CRICTL=https://github.com/kubernetes-sigs/cri-tools/releases/download/v${VERSION_CRICTL}/crictl-v${VERSION_CRICTL}-linux-amd64.tar.gz
ARG URL_ARTIFACT_NERDCTL=https://github.com/containerd/nerdctl/releases/download/v${VERSION_NERDCTL}/nerdctl-${VERSION_NERDCTL}-linux-amd64.tar.gz
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz
ARG URL_RAW_NERDCTL=https://raw.githubusercontent.com/containerd/nerdctl/refs/tags/v${VERSION_NERDCTL}
ARG URL_RAW_BUILDKIT=https://raw.githubusercontent.com/moby/buildkit/refs/tags/v${VERSION_BUILDKIT}

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

FROM prerequisite AS helm
ARG URL_ARTIFACT_HELM
ADD ${URL_ARTIFACT_HELM} /tmp/helm.tar.gz
RUN tar -C /tmp -xzvf /tmp/helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64 /tmp/helm.tar.gz

FROM helm AS cni
# install CNI plugins
ADD ${URL_ARTIFACT_CNI} /tmp/cni-plugins.tgz
RUN mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin /tmp/cni-plugins.tgz && \
    rm /tmp/cni-plugins.tgz

FROM cni AS crictl
ARG URL_ARTIFACT_CRICTL
ARG DIR_BIN
RUN curl -L ${URL_ARTIFACT_CRICTL} | tar -C ${DIR_BIN} -xz && \
    echo 'runtime-endpoint: unix:///var/run/containerd/containerd.sock' > /etc/crictl.yaml

FROM crictl AS buildkit
ARG URL_ARTIFACT_BUILDKIT
ARG URL_RAW_NERDCTL
ARG URL_RAW_BUILDKIT
# install buildkit
# https://github.com/containerd/nerdctl/blob/v2.1.3/docs/build.md#rootful
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# enable containerd worker
ADD ${URL_RAW_NERDCTL}/Dockerfile.d/etc_buildkit_buildkitd.toml /etc/buildkit/buildkitd.toml
# config systemd
ADD ${URL_RAW_BUILDKIT}/examples/systemd/system/buildkit.service /usr/local/lib/systemd/system/buildkit.service
ADD ${URL_RAW_BUILDKIT}/examples/systemd/system/buildkit.socket /usr/local/lib/systemd/system/buildkit.socket
RUN systemctl enable buildkit.service

FROM buildkit AS nerdctl
ARG URL_ARTIFACT_NERDCTL
# install nerdctl
ADD ${URL_ARTIFACT_NERDCTL} /tmp/nerdctl.tar.gz
RUN tar Cxzvvf /usr/local/bin /tmp/nerdctl.tar.gz \
    && rm /tmp/nerdctl.tar.gz

FROM nerdctl AS kube
ARG URL_ARTIFACT_K8S_BIN
ARG URL_ARTIFACT_K8S_RELEASE
ARG DIR_BIN
# install kubeadm, kubelet, kubectl
RUN set -ex && \
    cd ${DIR_BIN} && \
    curl -L --remote-name-all ${URL_ARTIFACT_K8S_BIN}/{kubeadm,kubelet,kubectl} && \
    chmod +x kubeadm kubelet kubectl && \
    curl -fL --show-error -o /etc/systemd/system/kubelet.service \
        "${URL_ARTIFACT_K8S_RELEASE}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service" && \
    mkdir -p /etc/systemd/system/kubelet.service.d && \
    curl -fL --show-error -o /etc/systemd/system/kubelet.service.d/10-kubeadm.conf \
        "${URL_ARTIFACT_K8S_RELEASE}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf"

FROM kube AS preflight
ARG VERSION_K8S
COPY --chmod=755 pull.sh /tmp/
RUN --security=insecure /tmp/pull.sh
