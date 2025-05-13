ARG VERSION_RUNC=1.1.0-ab3cd8d
ARG VERSION_UBUNTU=20.04
ARG VERSION_BASE_IMAGE=0.2.0
ARG URL_ARTIFACT_RUNC=https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v${VERSION_RUNC}-debug
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-${VERSION_UBUNTU}_v${VERSION_BASE_IMAGE}

FROM ${BASE_IMAGE}
ARG URL_ARTIFACT_RUNC
RUN apt update && apt install -y busybox-static && apt-get clean -y && rm -rf /var/lib/apt/lists/*
ADD ${URL_ARTIFACT_RUNC} /tmp/runc.amd64
RUN install -m 755 /tmp/runc.amd64 /usr/local/sbin/runc && rm /tmp/runc.amd64
