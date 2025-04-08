ARG VERSION_CONTAINERD=2.0.4
ARG VERSION_NERDCTL=2.0.4
ARG VERSION_BUILDKIT=0.20.2
ARG VERSION_CNI=1.6.2
ARG IMAGE_CONTAINERD=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}_v0.1.0
ARG URL_ARTIFACT_NERDCTL=https://github.com/containerd/nerdctl/releases/download/v${VERSION_NERDCTL}/nerdctl-${VERSION_NERDCTL}-linux-amd64.tar.gz
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz

FROM ${IMAGE_CONTAINERD} AS buildkit
ARG VERSION_BUILDKIT
ARG URL_ARTIFACT_BUILDKIT
# install buildkit
# https://github.com/containerd/nerdctl/blob/v2.0.4/docs/build.md#rootful
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# enable containerd worker
RUN mkdir -p /etc/buildkit/ && \
    cat >> /etc/buildkit/buildkitd.toml <<EOF 
[worker.oci]
  enabled = false

[worker.containerd]
  enabled = true
  # namespace should be "k8s.io" for Kubernetes (including Rancher Desktop)
  namespace = "default"
EOF
# config systemd
ADD https://raw.githubusercontent.com/moby/buildkit/refs/tags/v${VERSION_BUILDKIT}/examples/systemd/system/buildkit.service /usr/local/lib/systemd/system/buildkit.service
ADD https://raw.githubusercontent.com/moby/buildkit/refs/tags/v${VERSION_BUILDKIT}/examples/systemd/system/buildkit.socket /usr/local/lib/systemd/system/buildkit.socket
RUN systemctl enable buildkit.service

FROM buildkit AS cni
ARG VERSION_CNI
# install CNI plugins
RUN apt update && \
    apt install -y iptables && \
    rm -rf /var/lib/apt/lists/*
ADD https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI}/cni-plugins-linux-amd64-v${VERSION_CNI}.tgz /tmp/cni-plugins.tgz
RUN mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin /tmp/cni-plugins.tgz && \
    rm /tmp/cni-plugins.tgz

FROM cni
ARG URL_ARTIFACT_NERDCTL
# install nerdctl
ADD ${URL_ARTIFACT_NERDCTL} /tmp/nerdctl.tar.gz
RUN tar Cxzvvf /usr/local/bin /tmp/nerdctl.tar.gz \
    && rm /tmp/nerdctl.tar.gz
