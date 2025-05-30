# https://github.com/containerd/containerd/blob/v2.1.0/script/setup/runc-version
ARG VERSION_CONTAINERD=2.1.0
ARG VERSION_RUNC=1.3.0
ARG VERSION_DLV=1.24.1
ARG VERSION_IMAGE=0.1.0
ARG PATH_CTR=/usr/local/bin/ctr
ARG PATH_CONTAINERD=/usr/local/bin/containerd
ARG PATH_CONTAINERD_STRESS=/usr/local/bin/containerd-stress
ARG PATH_CONTAINERD_SHIM=/usr/local/bin/containerd-shim-runc-v2
ARG PATH_RUNC=/usr/local/sbin/runc
ARG DIR_BIN=/root/bin
ARG URL_ARTIFACT=https://github.com/ssst0n3/container-debug-artifacts/releases/download
ARG IMAGE_CONTAINERD=ssst0n3/docker_archive:ctr_containerd-v${VERSION_CONTAINERD}

FROM ${IMAGE_CONTAINERD}_v${VERSION_IMAGE}
ARG VERSION_CONTAINERD
ARG VERSION_RUNC
ARG VERSION_DLV
ARG URL_ARTIFACT
ARG PATH_CTR
ARG PATH_CONTAINERD
ARG PATH_CONTAINERD_STRESS
ARG PATH_CONTAINERD_SHIM
ARG PATH_RUNC
ARG DIR_BIN
# debug binaries
RUN mkdir -p ${DIR_BIN}
ADD --chmod=755 ${URL_ARTIFACT}/containerd/containerd-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/containerd.debug
ADD --chmod=755 ${URL_ARTIFACT}/containerd/containerd-stress-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/containerd-stress.debug
ADD --chmod=755 ${URL_ARTIFACT}/containerd/containerd-shim-runc-v2-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/containerd-shim-runc-v2.debug
ADD --chmod=755 ${URL_ARTIFACT}/containerd/ctr-v${VERSION_CONTAINERD}-debug ${DIR_BIN}/ctr.debug
ADD --chmod=755 ${URL_ARTIFACT}/runc/runc-v${VERSION_RUNC}-debug-flag ${DIR_BIN}/runc.debug
ADD --chmod=755 ${URL_ARTIFACT}/dlv/dlv-v${VERSION_DLV} /usr/local/bin/dlv
# debug scripts
COPY --chmod=755 debug.sh /usr/local/bin/
COPY --chmod=755 attach.sh /usr/local/bin/
# back up real binaries
RUN cp ${PATH_CTR} ${DIR_BIN}/ctr.real && \
    cp ${PATH_CONTAINERD} ${DIR_BIN}/containerd.real && \
    cp ${PATH_CONTAINERD_STRESS} ${DIR_BIN}/containerd-stress.real && \
    cp ${PATH_CONTAINERD_SHIM} ${DIR_BIN}/containerd-shim-runc-v2.real && \
    cp ${PATH_RUNC} ${DIR_BIN}/runc.real
