ARG VERSION_RUNC=1.3.0-rc.1
ARG CRIU_REPO=https://download.opensuse.org/repositories/devel:/tools:/criu/Debian_12
ARG KEYFILE=/usr/share/keyrings/criu-repo-keyring.gpg

FROM ssst0n3/docker_archive:ctr_runc-v${VERSION_RUNC}_v0.1.0
ARG CRIU_REPO
ARG KEYFILE
RUN apt update && apt install -y gpg
RUN wget -nv ${CRIU_REPO}/Release.key -O- | gpg --dearmor > ${KEYFILE} && \
    echo "deb [signed-by=${KEYFILE}] ${CRIU_REPO}/ /" > /etc/apt/sources.list.d/criu.list && \
    apt update && \
    apt install -y criu=4.1-1 && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*
