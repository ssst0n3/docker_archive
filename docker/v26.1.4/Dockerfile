FROM ssst0n3/docker_archive:ctr_ubuntu-22.04_v0.1.0

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
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce=5:26.1.4-1~ubuntu.22.04~jammy \
    docker-ce-cli=5:26.1.4-1~ubuntu.22.04~jammy \
    containerd.io=1.6.33-1 \
    docker-buildx-plugin=0.14.1-1~ubuntu.22.04~jammy \
    docker-compose-plugin=2.27.1-1~ubuntu.22.04~jammy
