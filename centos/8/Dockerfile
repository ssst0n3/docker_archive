FROM centos:8

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
RUN echo "root:root" | chpasswd