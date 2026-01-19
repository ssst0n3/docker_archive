ARG VERSION_K8S=1.35.0
ARG VERSION_K8S_MAIN=1.35
# the lowest version of kind supported k8s v1.35.0: https://github.com/kubernetes-sigs/kind/releases/tag/v0.31.0
# https://github.com/kubernetes-sigs/kind/blob/v0.31.0/images/base/Dockerfile#L125
ARG VERSION_CONTAINERD=2.2.0
# https://github.com/kubernetes-sigs/kind/blob/v0.31.0/images/base/Dockerfile#L173
ARG VERSION_CNI_PLUGINS=1.8.0
# https://helm.sh/docs/topics/version_skew/
# https://github.com/helm/helm/releases
# There's no helm support for k8s v1.35.0, just use the latest version of helm is v4.0.4 when this Dockerfile is created
ARG VERSION_HELM=4.0.4
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI_PLUGINS}/cni-plugins-linux-amd64-v${VERSION_CNI_PLUGINS}.tgz
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

FROM install_kube AS preflight
ARG VERSION_K8S
COPY --chmod=755 pull.sh /tmp/
RUN --security=insecure /tmp/pull.sh

