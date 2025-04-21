ARG VERSION_RUNC=1.3.0-rc.1
ARG URL_ARTIFACT_RUNC=https://github.com/opencontainers/runc/releases/download/v${VERSION_RUNC}/runc.amd64

FROM ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.1.0
ARG URL_ARTIFACT_RUNC
RUN apt update && apt install -y busybox-static vim jq && apt-get clean -y
ADD ${URL_ARTIFACT_RUNC} /tmp/runc.amd64
RUN install -m 755 /tmp/runc.amd64 /usr/local/sbin/runc && rm /tmp/runc.amd64
