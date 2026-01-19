# ================================
# CONFIG: version pins
# ================================
ARG HOSTNAME=nerdctl-0-10-0
ARG VERSION_NERDCTL=0.10.0
# https://github.com/containerd/nerdctl/blob/v0.10.0/Dockerfile#L19
ARG VERSION_CONTAINERD=1.5.2
# https://github.com/containerd/nerdctl/blob/v0.10.0/Dockerfile#L21
ARG VERSION_CNI=0.9.1
# https://github.com/containerd/nerdctl/blob/v0.10.0/Dockerfile#L26
ARG VERSION_BUILDKIT=0.8.3
ARG VERSION_IMAGE_CONTAINERD=0.1.0

# ================================
# Internal Variables
# ================================
ARG IMAGE_CONTAINERD=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_NERDCTL=https://github.com/containerd/nerdctl/releases/download/v${VERSION_NERDCTL}/nerdctl-${VERSION_NERDCTL}-linux-amd64.tar.gz
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI}/cni-plugins-linux-amd64-v${VERSION_CNI}.tgz
ARG URL_RAW_CONTAINERD=https://raw.githubusercontent.com/containerd/containerd/refs/tags/v${VERSION_CONTAINERD}

# ================================
# Build Stages
# ================================
FROM ${IMAGE_CONTAINERD}_v${VERSION_IMAGE_CONTAINERD} AS buildkit
ARG URL_ARTIFACT_BUILDKIT
ARG URL_RAW_CONTAINERD
# install buildkit
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# enable containerd worker
COPY buildkitd.toml /etc/buildkit/buildkitd.toml
# https://github.com/containerd/nerdctl/blob/v0.10.0/Dockerfile#L115-L120
ADD ${URL_RAW_CONTAINERD}/containerd.service /tmp/containerd.service
RUN cd /usr/local/lib/systemd/system && \
  sedcomm='s@bin/containerd@bin/buildkitd@g; s@(Description|Documentation)=.*@@' && \
  sed -E "${sedcomm}" /tmp/containerd.service > buildkit.service && \
  echo "" >> buildkit.service && \
  echo "# This file was converted from containerd.service, with \`sed -E '${sedcomm}'\`" >> buildkit.service && \
  systemctl enable buildkit.service

FROM buildkit AS cni
ARG URL_ARTIFACT_CNI
# install CNI plugins
RUN apt update && \
    apt install -y iptables && \
    rm -rf /var/lib/apt/lists/*
ADD ${URL_ARTIFACT_CNI} /tmp/cni-plugins.tgz
RUN mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin /tmp/cni-plugins.tgz && \
    rm /tmp/cni-plugins.tgz

FROM cni AS nerdctl
ARG URL_ARTIFACT_NERDCTL
# install nerdctl
ADD ${URL_ARTIFACT_NERDCTL} /tmp/nerdctl.tar.gz
RUN tar Cxzvvf /usr/local/bin /tmp/nerdctl.tar.gz \
    && rm /tmp/nerdctl.tar.gz

FROM nerdctl AS final
ARG HOSTNAME
RUN echo "${HOSTNAME}" > /etc/hostname
