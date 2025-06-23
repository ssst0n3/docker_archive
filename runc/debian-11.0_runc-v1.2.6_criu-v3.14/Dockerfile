ARG VERSION_CRIU=3.14
ARG VERSION_RUNC=1.2.6
ARG VERSION_DEBIAN=11.0
ARG VERSION_IMAGE=0.1.0
ARG IMAGE_RUNC=ssst0n3/docker_archive:ctr_debian-${VERSION_DEBIAN}_runc-v${VERSION_RUNC}
ARG URL_ARTIFACT_CRIU=https://github.com/checkpoint-restore/criu/archive/v${VERSION_CRIU}.tar.gz

FROM debian:${VERSION_DEBIAN} AS criu
ARG URL_ARTIFACT_CRIU
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcap-dev \
    libnet-dev \
    libnl-3-dev \
    libprotobuf-c-dev \
    libprotobuf-dev \
    protobuf-c-compiler \
    protobuf-compiler \
    python3-protobuf \
    libnftables-dev \
    build-essential \
    pkg-config \
    ca-certificates \
    curl

RUN mkdir -p /usr/src/criu \
    && update-ca-certificates \
    && curl -sSL ${URL_ARTIFACT_CRIU} | tar -C /usr/src/criu/ -xz --strip-components=1 \
    && cd /usr/src/criu \
    && make \
    && make PREFIX=/build/ install-criu

FROM ${IMAGE_RUNC}_v${VERSION_IMAGE}
RUN apt-get update && apt-get install -y --no-install-recommends \
    libprotobuf-c1 \
    libnl-3-200 \
    libnet1 \
    libnftables1 \
    iptables \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY --from=criu          /build/ /usr/local/
