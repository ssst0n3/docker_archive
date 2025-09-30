ARG HOSTNAME=docker-23-0-0-devicemapper
ARG VERSION_DOCKER=23.0.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}
ARG VERSION_IMAGE=0.1.0

FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG HOSTNAME
RUN mkdir -p /etc/docker &&\
    echo '{"storage-driver": "devicemapper"}' > /etc/docker/daemon.json && \
    echo ${HOSTNAME} > /etc/hostname
