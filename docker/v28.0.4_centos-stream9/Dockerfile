ARG VERSION_DOCKER=3:28.0.4-1.el9
ARG VERSION_DOCKER_CLI=1:28.0.4-1.el9
ARG VERSION_CONTAINERD=1.7.27-3.1.el9
ARG VERSION_BUILDX=0.22.0-1.el9
ARG VERSION_COMPOSE=2.34.0-1.el9
ARG VERSION_CENTOS=stream9
ARG VERSION_IMAGE=0.2.0
ARG HOSTNAME=docker-28-0-4-centos-stream9

FROM ssst0n3/docker_archive:ctr_centos-${VERSION_CENTOS}_v${VERSION_IMAGE}
ARG VERSION_DOCKER
ARG VERSION_DOCKER_CLI
ARG VERSION_CONTAINERD
ARG VERSION_BUILDX
ARG VERSION_COMPOSE
ARG HOSTNAME
# https://docs.docker.com/engine/install/centos/#set-up-the-repository

# Set up the repository
RUN dnf -y install dnf-plugins-core && \
    dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker Engine
# RUN dnf list \
#     docker-ce \
#     docker-ce-cli \
#     containerd.io \
#     docker-buildx-plugin \
#     docker-compose-plugin \
#     --showduplicates | sort -r
RUN dnf -y install \
    docker-ce-${VERSION_DOCKER} \
    docker-ce-cli-${VERSION_DOCKER_CLI} \
    containerd.io-${VERSION_CONTAINERD} \
    docker-buildx-plugin-${VERSION_BUILDX} \
    docker-compose-plugin-${VERSION_COMPOSE} && \
    systemctl enable docker
# relabel to prevent SELinux issues
RUN touch /.autorelabel
RUN echo ${HOSTNAME} > /etc/hostname