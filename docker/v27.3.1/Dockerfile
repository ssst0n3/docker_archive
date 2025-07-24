ARG HOSTNAME=docker-27-3-1
ARG VERSION_DOCKER=27.3.1
# https://github.com/moby/moby/blob/v27.3.1/Dockerfile#L199
ARG VERSION_CONTAINERD=1.7.22
# https://github.com/moby/moby/blob/v27.3.1/Dockerfile#L15
ARG VERSION_BUILDX=0.17.1
# https://github.com/moby/moby/blob/v27.3.1/Dockerfile#L16
ARG VERSION_COMPOSE=2.29.4
ARG VERSION_UBUNTU=24.04
ARG VERSION_IMAGE=0.3.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}

FROM docker/compose-bin:v${VERSION_COMPOSE} AS compose
FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG HOSTNAME
ARG VERSION_DOCKER
ARG VERSION_CONTAINERD
ARG VERSION_BUILDX
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
    docker-buildx-plugin=${VERSION_BUILDX}-1~ubuntu.24.04~noble
# docker-compose-plugin v2.29.4 package is missing in the official repo
COPY --from=compose /docker-compose /usr/libexec/docker/cli-plugins/docker-compose
RUN echo ${HOSTNAME} > /etc/hostname
