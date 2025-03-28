FROM ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.2.0 AS build

RUN apt update && apt install -y busybox-static && rm -rf /var/lib/apt/lists/*

ADD https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.amd64 /tmp/runc.amd64
RUN install -m 755 /tmp/runc.amd64 /usr/local/sbin/runc && rm /tmp/runc.amd64

# squash
FROM scratch AS release
COPY --from=build / /