FROM ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.1.0

RUN apt update && apt install -y busybox-static

ADD https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.amd64 /tmp/runc.amd64
RUN install -m 755 /tmp/runc.amd64 /usr/local/sbin/runc && rm /tmp/runc.amd64
