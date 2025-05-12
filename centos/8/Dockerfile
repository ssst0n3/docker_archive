ARG VERSION_CENTOS=8
ARG BASE_IMAGE=centos:${VERSION_CENTOS}
ARG SSH_PASSWORD=root
ARG SSH_PUB_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtOfmNu0t6Z3bEg47tdMkTNZdv7+Fd3KWTD0xNk5Woe default@docker_archive'

FROM ${BASE_IMAGE} AS build
ARG SSH_PASSWORD
ARG SSH_PUB_KEY

# Update repository URLs to use vault.centos.org
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# install common packages
RUN dnf install -y epel-release && \
    dnf install -y xterm vim jq && \
    dnf clean all

# ssh
RUN dnf install -y openssh-server && \
    dnf clean all && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo "root:root" | chpasswd && \
    mkdir -p /root/.ssh && \
    echo ${SSH_PUB_KEY} >> /root/.ssh/authorized_keys
