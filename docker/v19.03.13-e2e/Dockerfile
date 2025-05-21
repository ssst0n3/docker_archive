ARG VERSION_DOCKER=19.03.13
ARG VERSION_BASE_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}

FROM ${BASE_IMAGE}_v${VERSION_BASE_IMAGE}
RUN apt update && \
    apt install -y --no-install-recommends \
    make \
    && rm -rf /var/lib/apt/lists/*
