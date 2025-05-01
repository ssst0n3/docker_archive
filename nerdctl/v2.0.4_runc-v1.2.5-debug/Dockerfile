ARG VERSION_RUNC=1.2.5
ARG VERSION_DLV=1.24.2
ARG URL_ARTIFACT_RUNC=https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v${VERSION_RUNC}-debug-flag
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}
ARG VERSION_NERDCTL=2.0.4
ARG VERSION_IMAGE=0.1.0
ARG PATH_RUNC=/usr/local/sbin/runc
ARG IMAGE_NERDCTL=ssst0n3/docker_archive:ctr_nerdctl-v${VERSION_NERDCTL}_v${VERSION_IMAGE}

FROM ${IMAGE_NERDCTL}
ARG URL_ARTIFACT_RUNC
ARG URL_ARTIFACT_DLV
ARG PATH_RUNC
ADD --chmod=755 ${URL_ARTIFACT_RUNC} /root/runc-debug-flag
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
COPY --chmod=755 runc.debug /root/runc.debug
COPY --chmod=755 attach.sh /usr/local/bin/
RUN mv ${PATH_RUNC} /root/runc.real && \
    ln -s /root/runc.real ${PATH_RUNC}