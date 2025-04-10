FROM quay.io/centos/centos:stream9

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
RUN echo "root:root" | chpasswd
