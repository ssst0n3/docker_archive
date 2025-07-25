ARG HOSTNAME=docker-20-10-13
ARG VERSION_DOCKER=20.10.13
# https://github.com/moby/moby/blob/v20.10.13/hack/dockerfile/install/containerd.installer#L18
ARG VERSION_CONTAINERD=1.5.10
ARG VERSION_UBUNTU=22.04
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}
ARG VERSION_IMAGE=0.2.0

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
RUN apt-get update && \
   apt-cache madison docker-ce \
   containerd.io \
   docker-buildx-plugin \
   docker-compose-plugin
# https://web.archive.org/web/20220215211107/https://docs.docker.com/engine/install/ubuntu/
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce=5:${VERSION_DOCKER}~3-0~ubuntu-jammy \
    docker-ce-cli=5:${VERSION_DOCKER}~3-0~ubuntu-jammy \
    containerd.io=${VERSION_CONTAINERD}-1
RUN echo ${HOSTNAME} > /etc/hostname
