ARG HOSTNAME=nerdctl-2-1-2-apparmor
ARG VERSION_NERDCTL=2.1.2
ARG IMAGE_NERDCTL=ssst0n3/docker_archive:ctr_nerdctl-v${VERSION_NERDCTL}
ARG VERSION_IMAGE=0.1.0

FROM ${IMAGE_NERDCTL}_v${VERSION_IMAGE}
ARG HOSTNAME
RUN apt update && \
    apt install -y apparmor && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo ${HOSTNAME} > /etc/hostname
