FROM ubuntu:16.04

# install packages
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y xterm

# ssh
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y openssh-server && \
  sed -i 's/PermitRootLogin/# PermitRootLogin/g' /etc/ssh/sshd_config && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo root:root | chpasswd

