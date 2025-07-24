ARG HOSTNAME=docker-27-0-3
ARG VERSION_DOCKER=27.0.3
# https://github.com/moby/moby/blob/v27.0.3/Dockerfile#L199
ARG VERSION_CONTAINERD=1.7.18
# https://github.com/moby/moby/blob/v27.0.3/Dockerfile#L15
ARG VERSION_BUILDX=0.24.0
# https://github.com/moby/moby/blob/v27.0.3/Dockerfile#L16
ARG VERSION_COMPOSE=2.28.1
ARG VERSION_UBUNTU=24.04
ARG VERSION_IMAGE=0.3.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}

FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG HOSTNAME
ARG VERSION_DOCKER
ARG VERSION_CONTAINERD
ARG VERSION_BUILDX
ARG VERSION_COMPOSE
# Add Docker's official GPG key; Add the repository to Apt sources:
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    printf "%s\n" \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") test" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null 
# RUN apt-get update && \
#    apt-cache madison docker-ce \
#    containerd.io \
#    docker-buildx-plugin \
#    docker-compose-plugin
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce=5:${VERSION_DOCKER}-1~ubuntu.24.04~noble \
    docker-ce-cli=5:${VERSION_DOCKER}-1~ubuntu.24.04~noble \
    containerd.io=${VERSION_CONTAINERD}-1 \
    docker-buildx-plugin=${VERSION_BUILDX}-1~ubuntu.24.04~noble \
    docker-compose-plugin=${VERSION_COMPOSE}-1~ubuntu.24.04~noble
RUN echo ${HOSTNAME} > /etc/hostname
