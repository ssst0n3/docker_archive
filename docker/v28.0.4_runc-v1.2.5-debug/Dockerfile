ARG VERSION_DOCKER=28.0.4
ARG VERSION_RUNC=1.2.5
ARG VERSION_DLV=1.24.2

# install runc-v1.2.5-debug
FROM ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}_v0.1.0
ARG VERSION_RUNC
ARG VERSION_DLV
ADD https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v${VERSION_RUNC}-debug-flag /root/runc-debug-flag
ADD https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV} /usr/local/bin/dlv
COPY runc.debug /root/runc.debug
COPY attach.sh /usr/local/bin/
RUN chmod +x /root/runc-debug-flag /usr/local/bin/dlv && \
    mv /usr/bin/runc /root/runc.real && \
    ln -s /root/runc.real /usr/bin/runc