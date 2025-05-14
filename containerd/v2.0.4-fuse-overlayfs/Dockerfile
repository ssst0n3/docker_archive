ARG VERSION_CONTAINERD=2.0.4
# https://github.com/containerd/nerdctl/blob/v2.0.4/Dockerfile#L36
ARG VERSION_FUSE_OVERLAYFS=1.14
# https://github.com/containerd/nerdctl/blob/v2.0.4/Dockerfile#L37
ARG VERSION_CONTAINERD_FUSE_OVERLAYFS=2.1.2
ARG VERSION_IMAGE=0.2.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}
ARG URL_ARTIFACT_FUSE_OVERLAYFS=https://github.com/containers/fuse-overlayfs/releases/download/v${VERSION_FUSE_OVERLAYFS}/fuse-overlayfs-x86_64
ARG URL_ARTIFACT_CONTAINERD_FUSE_OVERLAYFS=https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v${VERSION_CONTAINERD_FUSE_OVERLAYFS}/containerd-fuse-overlayfs-${VERSION_CONTAINERD_FUSE_OVERLAYFS}-linux-amd64.tar.gz

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS build
ARG URL_ARTIFACT_FUSE_OVERLAYFS
ARG URL_ARTIFACT_CONTAINERD_FUSE_OVERLAYFS
# configure snapshotter
## install fuse3
RUN apt-get update && apt-get install -y fuse3 && rm -rf /var/lib/apt/lists/*
## install fuse-overlayfs
ADD --chmod=755 ${URL_ARTIFACT_FUSE_OVERLAYFS} /usr/local/bin/fuse-overlayfs
## install containerd-fuse-overlayfs
ADD ${URL_ARTIFACT_CONTAINERD_FUSE_OVERLAYFS} /tmp/fuse-overlayfs-snapshotter.tar.gz
RUN tar -C /usr/local/bin -xzvf /tmp/fuse-overlayfs-snapshotter.tar.gz && \
    rm /tmp/fuse-overlayfs-snapshotter.tar.gz
COPY containerd-fuse-overlayfs.service /etc/systemd/system/containerd-fuse-overlayfs.service
RUN systemctl enable containerd-fuse-overlayfs.service
## setup containerd config
RUN mkdir -p /etc/containerd && \
    containerd config default > /etc/containerd/config.toml && \
    sed -i "s/snapshotter = 'overlayfs'/snapshotter = 'fuse-overlayfs'/" /etc/containerd/config.toml
RUN cat >> /etc/containerd/config.toml <<EOF
[proxy_plugins]
[proxy_plugins."fuse-overlayfs"]
    type = "snapshot"
    address = "/run/containerd-fuse-overlayfs.sock"
EOF
