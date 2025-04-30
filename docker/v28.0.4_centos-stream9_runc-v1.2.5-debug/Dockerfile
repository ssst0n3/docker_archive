ARG VERSION_RUNC=1.2.5
ARG VERSION_DLV=1.24.2
ARG URL_ARTIFACT_RUNC=https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v${VERSION_RUNC}-debug-flag
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}

# install runc-v1.2.5-debug
FROM ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.1.0
ARG URL_ARTIFACT_RUNC
ARG URL_ARTIFACT_DLV
ADD --chmod=755 ${URL_ARTIFACT_RUNC} /root/runc-debug-flag
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
COPY --chmod=755 runc.debug /root/runc.debug
COPY --chmod=755 attach.sh /usr/local/bin/
RUN mv /usr/bin/runc /root/runc.real && \
    ln -s /root/runc.real /usr/bin/runc