ARG VERSION_DEBIAN=11.0-slim
ARG BASE_IMAGE=debian:${VERSION_DEBIAN}
ARG SSH_PASSWORD=root
ARG SSH_PUB_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtOfmNu0t6Z3bEg47tdMkTNZdv7+Fd3KWTD0xNk5Woe default@docker_archive'

FROM ${BASE_IMAGE} AS build
ARG SSH_PASSWORD
ARG SSH_PUB_KEY

# install common packages
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y xterm vim jq && \
  rm -rf /var/lib/apt/lists/*

# ssh
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y openssh-server && \
  rm -rf /var/lib/apt/lists/* && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo root:root | chpasswd && \
  mkdir -p /root/.ssh && \
  echo ${SSH_PUB_KEY} >> /root/.ssh/authorized_keys
