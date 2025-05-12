ARG VERSION_CENTOS=stream9
ARG BASE_IMAGE=quay.io/centos/centos:${VERSION_CENTOS}
ARG SSH_PASSWORD=root
ARG SSH_PUB_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtOfmNu0t6Z3bEg47tdMkTNZdv7+Fd3KWTD0xNk5Woe default@docker_archive'

FROM ${BASE_IMAGE}
ARG SSH_PASSWORD
ARG SSH_PUB_KEY

# install common packages
RUN dnf install -y epel-release && \
    dnf install -y xterm vim jq openssh-server && \
    dnf clean all
# RUN microdnf install -y epel-release \
#     && microdnf install -y xterm vim jq openssh-server \
#     && microdnf clean all

# ssh
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo "root:root" | chpasswd && \
    mkdir -p /root/.ssh && \
    echo ${SSH_PUB_KEY} >> /root/.ssh/authorized_keys

