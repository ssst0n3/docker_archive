# https://github.com/containerd/containerd/blob/v2.1.0-rc.0/script/setup/runc-version
ARG VERSION_RUNC=1.2.6
ARG VERSION_CONTAINERD=2.1.0-rc.0
ARG VERSION_IMAGE=0.2.0
ARG IMAGE_RUNC=ssst0n3/docker_archive:ctr_runc-v${VERSION_RUNC}
ARG URL_ARTIFACT_CONTAINERD=https://github.com/containerd/containerd/releases/download/v${VERSION_CONTAINERD}/containerd-${VERSION_CONTAINERD}-linux-amd64.tar.gz
ARG URL_ARTIFACT_SYSTEMD=https://raw.githubusercontent.com/containerd/containerd/refs/tags/v${VERSION_CONTAINERD}/containerd.service

FROM ${IMAGE_RUNC}_v${VERSION_IMAGE}
ARG URL_ARTIFACT_CONTAINERD
ARG URL_ARTIFACT_SYSTEMD
# install containerd
ADD ${URL_ARTIFACT_CONTAINERD} /tmp/containerd.tar.gz
RUN tar Cxzvf /usr/local /tmp/containerd.tar.gz \
    && rm /tmp/containerd.tar.gz

# config systemd
ADD ${URL_ARTIFACT_SYSTEMD} /usr/local/lib/systemd/system/containerd.service
