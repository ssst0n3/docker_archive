FROM ubuntu:14.04

# install packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y xterm

# ssh
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

