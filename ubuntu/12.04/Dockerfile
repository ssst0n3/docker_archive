FROM ubuntu:12.04

# apt sources
RUN sed -i 's/archive/old-releases/g' /etc/apt/sources.list

# install packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y xterm vim

# ssh
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

