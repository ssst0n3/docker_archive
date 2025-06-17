ARG VERSION_RUNC=1.3.0-rc.2
ARG VERSION_UBUNTU=24.04
ARG VERSION_BASE_IMAGE=0.2.0
ARG URL_ARTIFACT_RUNC=https://github.com/opencontainers/runc/releases/download/v${VERSION_RUNC}/runc.amd64
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_runc-v${VERSION_RUNC}_v${VERSION_BASE_IMAGE}
ARG CRIU_REPO=https://download.opensuse.org/repositories/devel:/tools:/criu/xUbuntu_${VERSION_UBUNTU}
ARG KEYFILE=/usr/share/keyrings/criu-repo-keyring.gpg

FROM ${BASE_IMAGE}
ARG CRIU_REPO
ARG KEYFILE
RUN apt update && \
    apt install -y gpg && \
    wget -nv $CRIU_REPO/Release.key -O- | gpg --dearmor > "$KEYFILE" && \
    echo "deb [signed-by=$KEYFILE] $CRIU_REPO/ /" > /etc/apt/sources.list.d/criu.list && \
    apt update && \
    apt install -y criu iptables && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/*
