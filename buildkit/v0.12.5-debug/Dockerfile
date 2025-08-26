ARG HOSTNAME=buildkit-0-12-5-debug
ARG VERSION_BUILDKIT=0.12.5
ARG IMAGE_BUILDKIT=ssst0n3/docker_archive:ctr_buildkit-v${VERSION_BUILDKIT}
ARG IMAGE_VERSION=0.1.0
ARG VERSION_DLV=1.20.2
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}
ARG DIR_BIN=/root/bin
ARG PATH_BUILDKITD=/usr/local/bin/buildkitd

FROM ${IMAGE_BUILDKIT}_v${IMAGE_VERSION} AS buildkit
ARG URL_ARTIFACT_DLV
ARG DIR_BIN
ARG PATH_BUILDKITD
RUN mkdir -p ${DIR_BIN}
# debug binaries
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
RUN cp ${PATH_BUILDKITD} ${DIR_BIN}/buildkitd.debug
# debug scripts
COPY --chmod=755 debug.sh /usr/local/bin/
# back up real binaries
# RUN cp ${PATH_BUILDKITD} ${DIR_BIN}/buildkitd.real

FROM buildkit
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname
