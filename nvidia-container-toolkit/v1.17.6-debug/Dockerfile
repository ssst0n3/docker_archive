ARG HOSTNAME=nvidia-container-toolkit-1-17-6-debug
ARG VERSION_NCT=1.17.6
ARG VERSION_RUNC=1.2.5
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v${VERSION_NCT}
ARG VERSION_IMAGE=0.9.0
ARG VERSION_DLV=1.24.2
ARG PATH_RUNC=/usr/bin/runc
ARG PATH_NCT=/usr/bin/nvidia-container-runtime
ARG DIR_BIN=/root/bin
ARG URL_ARTIFACT_NCT=https://github.com/ssst0n3/container-debug-artifacts/releases/download/nvidia-container-toolkit/nvidia-container-runtime-v${VERSION_NCT}-debug
ARG URL_ARTIFACT_RUNC=https://github.com/ssst0n3/container-debug-artifacts/releases/download/runc/runc-v${VERSION_RUNC}-debug-flag
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS debug
ARG URL_ARTIFACT_NCT
ARG URL_ARTIFACT_RUNC
ARG URL_ARTIFACT_DLV
ARG PATH_NCT
ARG PATH_RUNC
ARG DIR_BIN
RUN mkdir -p ${DIR_BIN}
# debug binaries
ADD --chmod=755 ${URL_ARTIFACT_NCT} ${DIR_BIN}/nvidia-container-runtime.debug
ADD --chmod=755 ${URL_ARTIFACT_RUNC} ${DIR_BIN}/runc.debug
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
# debug scripts
COPY --chmod=755 debug.sh /usr/local/bin/
COPY --chmod=755 attach.sh /usr/local/bin/
# back up real binaries
RUN cp ${PATH_NCT} ${DIR_BIN}/nvidia-container-runtime.real
RUN cp ${PATH_RUNC} ${DIR_BIN}/runc.real

FROM debug
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname
