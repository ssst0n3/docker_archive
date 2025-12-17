ARG HOSTNAME=docker-compose-2-40-1
ARG VERSION_COMPOSE=2.40.1
ARG VERSION_DOCKER=28.3.2
ARG VERSION_IMAGE=0.1.0

ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}
FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG HOSTNAME
ARG VERSION_COMPOSE
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-compose-plugin=${VERSION_COMPOSE}-1~ubuntu.24.04~noble && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN echo ${HOSTNAME} > /etc/hostname