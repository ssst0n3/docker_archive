ARG VERSION_PODMAN=5.5.1
ARG VERSION_IMAGE=0.1.0
ARG VERSION_DLV=1.24.2
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_podman-v${VERSION_PODMAN}
ARG URL_ARTIFACT_PODMAN=https://github.com/ssst0n3/container-debug-artifacts/releases/download/podman/podman-v${VERSION_PODMAN}-debug
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}
ARG DIR_BIN=/root/bin
ARG PATH_PODMAN=/usr/bin/podman

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS podman
ARG URL_ARTIFACT_PODMAN
ARG URL_ARTIFACT_DLV
ARG DIR_BIN
ARG PATH_PODMAN
# debug binaries
RUN mkdir -p ${DIR_BIN}
ADD --chmod=755 ${URL_ARTIFACT_PODMAN} ${DIR_BIN}/podman.debug
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
# debug scripts
COPY --chmod=755 debug.sh /usr/local/bin/
# back up real binaries
RUN cp ${PATH_PODMAN} ${DIR_BIN}/podman.real
