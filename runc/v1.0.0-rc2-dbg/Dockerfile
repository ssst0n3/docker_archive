ARG VERSION_RUNC=1.0.0-rc2
ARG URL_ARTIFACT_RUNC=https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v${VERSION_RUNC}-debug-flag
ARG VERSION_DLV=1.22.1
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_runc-v${VERSION_RUNC}_v0.2.0

FROM ${BASE_IMAGE}
ARG URL_ARTIFACT_RUNC
ARG URL_ARTIFACT_DLV
WORKDIR /root
RUN mkdir -p rootfs/bin/ && \
    cp /bin/busybox rootfs/bin/ && \
    ln -s /bin/busybox rootfs/bin/sh && \
    runc spec
ADD --chmod=755 ${URL_ARTIFACT_RUNC} /root/runc-debug-flag
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
COPY --chmod=755 runc.debug /root/runc.debug
COPY --chmod=755 attach.sh /usr/local/bin/
RUN mv /usr/local/sbin/runc /root/runc.real && \
    ln -s /root/runc.debug /usr/local/sbin/runc
