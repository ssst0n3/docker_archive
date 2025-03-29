ARG CONTAINERD_VERSION=2.0.4
ARG CONTAINERD_IMAGE=ssst0n3/docker_archive:ctr_containerd-v${CONTAINERD_VERSION}_v0.1.0
# https://github.com/containerd/nerdctl/blob/v2.0.4/Dockerfile#L36
ARG FUSE_OVERLAYFS_VERSION=1.14
# https://github.com/containerd/nerdctl/blob/v2.0.4/Dockerfile#L37
ARG CONTAINERD_FUSE_OVERLAYFS_VERSION=2.1.2

FROM ${CONTAINERD_IMAGE} AS build
ARG FUSE_OVERLAYFS_VERSION
ARG CONTAINERD_FUSE_OVERLAYFS_VERSION

# configure snapshotter
## install fuse3
RUN apt-get update && apt-get install -y fuse3 && rm -rf /var/lib/apt/lists/*

## install fuse-overlayfs
ADD https://github.com/containers/fuse-overlayfs/releases/download/v${FUSE_OVERLAYFS_VERSION}/fuse-overlayfs-x86_64 /usr/local/bin/fuse-overlayfs
RUN chmod +x /usr/local/bin/fuse-overlayfs

## install containerd-fuse-overlayfs
ADD https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v${CONTAINERD_FUSE_OVERLAYFS_VERSION}/containerd-fuse-overlayfs-${CONTAINERD_FUSE_OVERLAYFS_VERSION}-linux-amd64.tar.gz /tmp/fuse-overlayfs-snapshotter.tar.gz
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
