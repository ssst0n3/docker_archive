FROM ubuntu:22.04

# ssh
RUN apt update && apt install -y openssh-server && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo root:root | chpasswd

