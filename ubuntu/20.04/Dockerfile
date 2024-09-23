FROM ubuntu:20.04

# install packages
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y xterm

# ssh
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y openssh-server && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo root:root | chpasswd

