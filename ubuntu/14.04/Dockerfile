ARG VERSION_UBUNTU=14.04
ARG BASE_IMAGE=ubuntu:${VERSION_UBUNTU}
ARG SSH_PASSWORD=root
ARG SSH_PUB_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtOfmNu0t6Z3bEg47tdMkTNZdv7+Fd3KWTD0xNk5Woe default@docker_archive'

FROM ${BASE_IMAGE}
ARG SSH_PASSWORD
ARG SSH_PUB_KEY

RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y xterm vim jq openssh-server && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i 's/PermitRootLogin/# PermitRootLogin/g' /etc/ssh/sshd_config && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo root:root | chpasswd && \
  mkdir -p /root/.ssh/ && \
  echo ${SSH_PUB_KEY} >> /root/.ssh/authorized_keys
