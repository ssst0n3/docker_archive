ARG VERSION_NERDCTL=1.7.4
# https://github.com/containerd/nerdctl/blob/v1.7.4/Dockerfile#L21
ARG VERSION_CONTAINERD=1.7.13
# https://github.com/containerd/nerdctl/blob/v1.7.4/Dockerfile#L26
ARG VERSION_BUILDKIT=0.12.5
# https://github.com/containerd/nerdctl/blob/v1.7.4/Dockerfile#L23
ARG VERSION_CNI=1.4.0
ARG VERSION_IMAGE_CONTAINERD=0.1.0
ARG IMAGE_CONTAINERD=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_NERDCTL=https://github.com/containerd/nerdctl/releases/download/v${VERSION_NERDCTL}/nerdctl-${VERSION_NERDCTL}-linux-amd64.tar.gz
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI}/cni-plugins-linux-amd64-v${VERSION_CNI}.tgz
ARG URL_RAW_NERDCTL=https://raw.githubusercontent.com/containerd/nerdctl/refs/tags/v${VERSION_NERDCTL}
ARG URL_RAW_BUILDKIT=https://raw.githubusercontent.com/moby/buildkit/refs/tags/v${VERSION_BUILDKIT}

FROM ${IMAGE_CONTAINERD}_v${VERSION_IMAGE_CONTAINERD} AS buildkit
ARG URL_ARTIFACT_BUILDKIT
ARG URL_RAW_NERDCTL
ARG URL_RAW_BUILDKIT
# install buildkit
# https://github.com/containerd/nerdctl/blob/v2.1.1/docs/build.md#rootful
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# enable containerd worker
ADD ${URL_RAW_NERDCTL}/Dockerfile.d/etc_buildkit_buildkitd.toml /etc/buildkit/buildkitd.toml
# config systemd
ADD ${URL_RAW_BUILDKIT}/examples/systemd/system/buildkit.service /usr/local/lib/systemd/system/buildkit.service
ADD ${URL_RAW_BUILDKIT}/examples/systemd/system/buildkit.socket /usr/local/lib/systemd/system/buildkit.socket
RUN systemctl enable buildkit.service

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

FROM cni
ARG URL_ARTIFACT_NERDCTL
# install nerdctl
ADD ${URL_ARTIFACT_NERDCTL} /tmp/nerdctl.tar.gz
RUN tar Cxzvvf /usr/local/bin /tmp/nerdctl.tar.gz \
    && rm /tmp/nerdctl.tar.gz
