ARG HOSTNAME=docker-compose-2-39-4
ARG VERSION_COMPOSE=2.39.4
ARG VERSION_COMPOSE_PACKAGE=0~ubuntu.24.04~noble
ARG VERSION_DOCKER=28.3.2
ARG VERSION_IMAGE=0.1.0

ARG PACKAGE_COMPOSE=${VERSION_COMPOSE}-${VERSION_COMPOSE_PACKAGE}
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}
FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG HOSTNAME
ARG PACKAGE_COMPOSE
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-compose-plugin=${PACKAGE_COMPOSE} && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN echo ${HOSTNAME} > /etc/hostname

