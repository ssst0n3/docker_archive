# ================================
# Configuration Variables
# ================================
ARG HOSTNAME=runc-1-3-4
ARG VERSION_RUNC=1.3.4
ARG VERSION_UBUNTU=24.04
ARG VERSION_BASE_IMAGE=0.3.0

# ================================
# Internal Variables
# ================================
ARG URL_ARTIFACT_RUNC=https://github.com/opencontainers/runc/releases/download/v${VERSION_RUNC}/runc.amd64
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}_v${VERSION_BASE_IMAGE}

# ================================
# Build Stages
# ================================
FROM ${BASE_IMAGE}
ARG URL_ARTIFACT_RUNC
ARG HOSTNAME
RUN apt update && apt install -y busybox-static && apt-get clean -y && rm -rf /var/lib/apt/lists/*
ADD ${URL_ARTIFACT_RUNC} /tmp/runc.amd64
RUN install -m 755 /tmp/runc.amd64 /usr/local/sbin/runc && rm /tmp/runc.amd64
RUN echo ${HOSTNAME} > /etc/hostname
