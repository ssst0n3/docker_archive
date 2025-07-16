ARG VERSION_DOCKER=20.10.19
# https://github.com/moby/moby/blob/v20.10.19/hack/dockerfile/install/containerd.installer#L18
ARG VERSION_CONTAINERD_IO=1.6.8
ARG VERSION_PKG_DOCKER=5:${VERSION_DOCKER}~3-0~ubuntu-jammy
ARG VERSION_PKG_CONTAINERD_IO=${VERSION_CONTAINERD_IO}-1
ARG VERSION_PKG_COMPOSE=2.11.2~ubuntu-jammy
ARG VERSION_UBUNTU=22.04
ARG VERSION_BASE_IMAGE=0.2.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}

FROM ${BASE_IMAGE}_v${VERSION_BASE_IMAGE}
ARG VERSION_PKG_DOCKER
ARG VERSION_PKG_CONTAINERD_IO
ARG VERSION_PKG_COMPOSE
# Add Docker's official GPG key; Add the repository to Apt sources:
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null 

# # install docker-ce
# RUN apt-get update && \
#    apt-cache madison docker-ce \
#    containerd.io \
#    docker-buildx-plugin \
#    docker-compose-plugin

# https://web.archive.org/web/20221013184044/https://docs.docker.com/engine/install/ubuntu/
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce=${VERSION_PKG_DOCKER} \
    docker-ce-cli=${VERSION_PKG_DOCKER} \
    containerd.io=${VERSION_PKG_CONTAINERD_IO} \
    docker-compose-plugin=${VERSION_PKG_COMPOSE}
