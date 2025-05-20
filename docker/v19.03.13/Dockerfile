ARG VERSION_DOCKER=5:19.03.13~3-0~ubuntu-focal
ARG VERSION_CONTAINERD_IO=1.3.7-1
ARG VERSION_UBUNTU=20.04
ARG VERSION_BASE_IMAGE=0.2.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}

FROM ${BASE_IMAGE}_v${VERSION_BASE_IMAGE}
ARG VERSION_DOCKER
ARG VERSION_CONTAINERD_IO
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

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce=${VERSION_DOCKER} \
    docker-ce-cli=${VERSION_DOCKER} \
    containerd.io=${VERSION_CONTAINERD_IO}
