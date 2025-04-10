FROM ssst0n3/docker_archive:ctr_centos-stream9_v0.1.0

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
    docker-ce-3:28.0.4-1.el9 \
    docker-ce-cli-1:28.0.4-1.el9 \
    containerd.io-1.7.27-3.1.el9 \
    docker-buildx-plugin-0.22.0-1.el9 \
    docker-compose-plugin-2.34.0-1.el9 && \
    systemctl enable docker
# disable SELinux by /etc/selinux/config
RUN sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config