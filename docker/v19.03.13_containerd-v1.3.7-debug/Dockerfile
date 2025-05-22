ARG VERSION_DOCKER=19.03.13
ARG VERSION_CONTAINERD=1.3.7
ARG VERSION_DLV=1.5.0
ARG VERSION_BASE_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}
ARG URL_ARTIFACT_CONTAINERD=https://github.com/ssst0n3/container-debug-artifacts/releases/download/containerd
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}
ARG DIR_BINS=/root/bin

FROM ${BASE_IMAGE}_v${VERSION_BASE_IMAGE}
ARG VERSION_CONTAINERD
ARG URL_ARTIFACT_CONTAINERD
ARG URL_ARTIFACT_DLV
ARG DIR_BINS
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/containerd-shim-runc-v1-v${VERSION_CONTAINERD}-debug ${DIR_BINS}/containerd-shim-runc-v1-debug
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/containerd-shim-runc-v2-v${VERSION_CONTAINERD}-debug ${DIR_BINS}/containerd-shim-runc-v2-debug
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/containerd-shim-v${VERSION_CONTAINERD}-debug ${DIR_BINS}/containerd-shim-debug
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/containerd-v${VERSION_CONTAINERD}-debug ${DIR_BINS}/containerd-debug
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/ctr-v${VERSION_CONTAINERD}-debug ${DIR_BINS}/ctr-debug
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
COPY --chmod=755 containerd.debug ${DIR_BINS}/containerd.debug
RUN cp /usr/bin/containerd-shim-runc-v1 ${DIR_BINS}/containerd-shim-runc-v1.real && \
    cp /usr/bin/containerd-shim-runc-v2 ${DIR_BINS}/containerd-shim-runc-v2.real && \
    cp /usr/bin/containerd-shim ${DIR_BINS}/containerd-shim.real && \
    cp /usr/bin/containerd ${DIR_BINS}/containerd.real && \
    cp /usr/bin/ctr ${DIR_BINS}/ctr.real
