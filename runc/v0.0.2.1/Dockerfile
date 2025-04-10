FROM ssst0n3/docker_archive:ctr_ubuntu-16.04_v0.1.0

RUN apt update && apt install -y busybox-static vim jq && apt-get clean -y && rm -rf /var/lib/apt/lists/*

ADD https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v0.0.2.1-debug /tmp/runc.amd64
RUN install -m 755 /tmp/runc.amd64 /usr/local/sbin/runc && rm /tmp/runc.amd64
