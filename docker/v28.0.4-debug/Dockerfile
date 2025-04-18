ARG VERSION_DOCKER=28.0.4
ARG VERSION_RUNC=1.2.5
ARG VERSION_DLV=1.24.2
ARG URL_ARTIFACT_DOCKER=https://github.com/ssst0n3/container-debug-artifacts/releases/download/docker/dockerd-v${VERSION_DOCKER}-debug
ARG URL_ARTIFACT_RUNC=https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v${VERSION_RUNC}-debug-flag
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}

# install runc-v1.2.5-debug
FROM ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}_v0.1.0 AS runc_debug
ARG URL_ARTIFACT_RUNC
ARG URL_ARTIFACT_DLV
ADD ${URL_ARTIFACT_RUNC} /root/runc-debug-flag
ADD ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
COPY runc.debug /root/runc.debug
COPY attach.sh /usr/local/bin/
RUN chmod +x /root/runc-debug-flag /usr/local/bin/dlv && \
    mv /usr/bin/runc /root/runc.real && \
    ln -s /root/runc.real /usr/bin/runc

# install docker-v28.0.4-debug
FROM runc_debug AS docker_debug
ARG URL_ARTIFACT_DOCKER
ADD ${URL_ARTIFACT_DOCKER} /root/dockerd-debug
COPY docker.debug /root/dockerd.debug
RUN chmod +x /root/dockerd-debug && \
    mv /usr/bin/dockerd /root/dockerd.real && \
    ln -s /root/dockerd.debug /usr/bin/dockerd && \
    sed -i 's|^ExecStart=.*dockerd.*|ExecStart=dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient exec /root/dockerd-debug -- -H unix:///run/docker.sock --containerd=/run/containerd/containerd.sock|' /usr/lib/systemd/system/docker.service

FROM docker_debug
RUN apt update && apt install -y vim && apt clean && rm -rf /var/lib/apt/lists/*