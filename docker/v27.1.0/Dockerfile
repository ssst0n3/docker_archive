FROM ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.1.0

# Add Docker's official GPG key; Add the repository to Apt sources:
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null 

# install docker-ce
# RUN apt-get update
# RUN apt-cache madison docker-ce
# RUN apt-cache madison containerd.io
# RUN apt-cache madison docker-buildx-plugin
# RUN apt-cache madison docker-compose-plugin
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce=5:27.1.0-1~ubuntu.24.04~noble \
    docker-ce-cli=5:27.1.0-1~ubuntu.24.04~noble \
    containerd.io=1.7.20-1 \
    docker-buildx-plugin=0.16.1-1~ubuntu.24.04~noble \
    docker-compose-plugin=2.29.0-1~ubuntu.24.04~noble
