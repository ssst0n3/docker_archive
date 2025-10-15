ARG HOSTNAME=be-a-docker-escaper
ARG FLAG=rwctf{THIS_IS_A_TEST_FLAG}
ARG VERSION_UBUNTU=24.04
ARG VERSION_IMAGE=0.3.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS base
RUN apt update && \
    apt install -y docker.io && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

FROM base AS user
RUN useradd -m -s /home/ctf/run.sh -G docker ctf && \
    echo "ctf:ctf" | chpasswd
RUN printf '#!/bin/bash\ndocker run -ti -m 128m -v /var/run/docker.sock:/s busybox:latest # You are here!' > /home/ctf/run.sh && \
    chmod +x /home/ctf/run.sh

FROM user AS final
ARG HOSTNAME
ARG FLAG
RUN echo ${HOSTNAME} > /etc/hostname && \
    echo ${FLAG} > /root/flag
