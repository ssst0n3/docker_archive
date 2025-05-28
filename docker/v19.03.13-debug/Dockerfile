ARG VERSION_DOCKER=19.03.13
ARG VERSION_CONTAINERD=1.3.7
ARG VERSION_RUNC=1.0.0-rc10
ARG VERSION_DLV=1.5.0-fix-2168
ARG VERSION_BASE_IMAGE=0.1.0
ARG PATH_DOCKERD=/usr/bin/dockerd
ARG PATH_CTR=/usr/bin/ctr
ARG PATH_CONTAINERD=/usr/bin/containerd
ARG PATH_RUNC=/usr/bin/runc
ARG DIR_BIN=/root/bin
ARG URL_ARTIFACT=https://github.com/ssst0n3/container-debug-artifacts/releases/download
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}

FROM ${BASE_IMAGE}_v${VERSION_BASE_IMAGE}
ARG VERSION_DOCKER
ARG VERSION_CONTAINERD
ARG VERSION_RUNC
ARG VERSION_DLV
ARG URL_ARTIFACT
ARG PATH_DOCKERD
ARG PATH_CTR
ARG PATH_CONTAINERD
ARG PATH_RUNC
ARG DIR_BIN
RUN mkdir -p ${DIR_BIN}
# debug binaries
ADD --chmod=755 ${URL_ARTIFACT}/containerd/containerd-shim-runc-v1-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/containerd-shim-runc-v1.debug
ADD --chmod=755 ${URL_ARTIFACT}/containerd/containerd-shim-runc-v2-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/containerd-shim-runc-v2.debug
ADD --chmod=755 ${URL_ARTIFACT}/containerd/containerd-shim-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/containerd-shim.debug
ADD --chmod=755 ${URL_ARTIFACT}/containerd/containerd-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/containerd.debug
ADD --chmod=755 ${URL_ARTIFACT}/containerd/ctr-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/ctr.debug
ADD --chmod=755 ${URL_ARTIFACT}/docker/dockerd-v${VERSION_DOCKER}-debug ${DIR_BIN}/dockerd.debug
ADD --chmod=755 ${URL_ARTIFACT}/runc/runc-v${VERSION_RUNC}-debug-flag ${DIR_BIN}/runc.debug
ADD --chmod=755 ${URL_ARTIFACT}/dlv/dlv-v${VERSION_DLV} /usr/local/bin/dlv
# debug scripts
COPY --chmod=755 debug.sh /usr/local/bin/
COPY --chmod=755 attach.sh /usr/local/bin/
# back up real binaries
RUN cp ${PATH_DOCKERD} ${DIR_BIN}/dockerd.real && \
    cp ${PATH_CTR} ${DIR_BIN}/ctr.real && \
    cp ${PATH_CONTAINERD} ${DIR_BIN}/containerd.real && \
    cp ${PATH_CONTAINERD}-shim ${DIR_BIN}/containerd-shim.real && \
    cp ${PATH_CONTAINERD}-shim-runc-v1 ${DIR_BIN}/containerd-shim-runc-v1.real && \
    cp ${PATH_CONTAINERD}-shim-runc-v2 ${DIR_BIN}/containerd-shim-runc-v2.real && \
    cp ${PATH_RUNC} ${DIR_BIN}/runc.real
