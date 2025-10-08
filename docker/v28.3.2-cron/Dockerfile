ARG HOSTNAME=docker-28-3-2-cron
ARG VERSION_DOCKER=28.3.2
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}

FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG HOSTNAME
RUN apt update && \
    apt install -y cron && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo ${HOSTNAME} > /etc/hostname
