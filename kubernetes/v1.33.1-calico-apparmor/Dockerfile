ARG VERSION_K8S=1.33.1
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_K8S}-calico
ARG VERSION_IMAGE=0.1.0

FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG HOSTNAME
RUN apt update && \
    apt install -y apparmor && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
