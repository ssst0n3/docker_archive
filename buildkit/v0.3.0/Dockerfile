ARG HOSTNAME=buildkit-0-3-0
ARG VERSION_BUILDKIT=0.3.0
# https://github.com/moby/buildkit/blob/v0.3.0/hack/dockerfiles/test.buildkit.Dockerfile#L3
ARG VERSION_RUNC=1.0.0-rc6
ARG IMAGE_RUNC=ssst0n3/docker_archive:ctr_runc-v${VERSION_RUNC}
ARG IMAGE_VERSION=0.2.0
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz
# missing at v0.5.0, use v0.9.0 instead
ARG URL_GITRAW_BUILDKIT=https://raw.githubusercontent.com/moby/buildkit/refs/tags/v0.9.0

FROM ${IMAGE_RUNC}_v${IMAGE_VERSION} AS buildkit
ARG URL_ARTIFACT_BUILDKIT
ARG URL_GITRAW_BUILDKIT
# install buildkit
# https://github.com/containerd/nerdctl/blob/v2.0.4/docs/build.md#rootful
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# config systemd
ADD ${URL_GITRAW_BUILDKIT}/examples/systemd/buildkit.service /usr/local/lib/systemd/system/buildkit.service
ADD ${URL_GITRAW_BUILDKIT}/examples/systemd/buildkit.socket /usr/local/lib/systemd/system/buildkit.socket
RUN sed -i 's# --addr fd://##' /usr/local/lib/systemd/system/buildkit.service && \
    systemctl enable buildkit.service
# install git
RUN apt update && \
    apt install -y git && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

FROM buildkit
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname
