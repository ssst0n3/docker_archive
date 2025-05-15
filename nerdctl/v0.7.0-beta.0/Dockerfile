ARG VERSION_NERDCTL=0.7.0-beta.0
# https://github.com/containerd/nerdctl/blob/v0.7.0-beta.0/Dockerfile#L4
ARG VERSION_CONTAINERD=1.5.0-beta.2
# https://github.com/containerd/nerdctl/blob/v0.7.0-beta.0/Dockerfile#L11
ARG VERSION_BUILDKIT=0.8.2
# https://github.com/containerd/nerdctl/blob/v0.7.0-beta.0/Dockerfile#L6
ARG VERSION_CNI=0.8.2
ARG VERSION_IMAGE_CONTAINERD=0.1.0
ARG IMAGE_CONTAINERD=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_NERDCTL=https://github.com/containerd/nerdctl/releases/download/v${VERSION_NERDCTL}/nerdctl-${VERSION_NERDCTL}-linux-amd64.tar.gz
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz
ARG URL_ARTIFACT_CNI=https://github.com/containernetworking/plugins/releases/download/v${VERSION_CNI}/cni-plugins-linux-amd64-v${VERSION_CNI}.tgz
ARG URL_RAW_NERDCTL=https://raw.githubusercontent.com/containerd/nerdctl/refs/tags/v${VERSION_NERDCTL}

FROM ${IMAGE_CONTAINERD}_v${VERSION_IMAGE_CONTAINERD} AS buildkit
ARG URL_ARTIFACT_BUILDKIT
ARG URL_RAW_NERDCTL
# install buildkit
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# # enable containerd worker
# ADD ${URL_RAW_NERDCTL}/Dockerfile.d/etc_buildkit_buildkitd.toml /etc/buildkit/buildkitd.toml
# config systemd
# COPY buildkit.service /usr/local/lib/systemd/system/buildkit.service
# COPY buildkit.socket /usr/local/lib/systemd/system/buildkit.socket
ADD ${URL_RAW_NERDCTL}/Dockerfile.d/buildkitd.service /etc/systemd/system/buildkitd.service
RUN sed -i s/docker-entrypoint.target/multi-user.target/g /etc/systemd/system/buildkitd.service && \
    systemctl enable buildkitd.service

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
