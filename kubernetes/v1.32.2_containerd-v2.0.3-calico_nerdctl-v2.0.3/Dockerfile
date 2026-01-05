# syntax=docker/dockerfile:1-labs
ARG HOSTNAME=kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3
ARG VERSION_NERDCTL=2.0.3
# https://github.com/containerd/nerdctl/blob/v2.0.3/Dockerfile#L26
ARG VERSION_BUILDKIT=0.19.0
ARG VERSION_IMAGE=0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico
ARG URL_ARTIFACT_NERDCTL=https://github.com/containerd/nerdctl/releases/download/v${VERSION_NERDCTL}/nerdctl-${VERSION_NERDCTL}-linux-amd64.tar.gz
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz
ARG URL_RAW_BUILDKIT=https://raw.githubusercontent.com/moby/buildkit/refs/tags/v${VERSION_BUILDKIT}

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS buildkit
ARG URL_ARTIFACT_BUILDKIT
ARG URL_RAW_BUILDKIT
# install buildkit
# https://github.com/containerd/nerdctl/blob/v2.0.3/docs/build.md#rootful
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# enable containerd worker
COPY buildkitd.toml /etc/buildkit/buildkitd.toml
# config systemd
ADD ${URL_RAW_BUILDKIT}/examples/systemd/system/buildkit.service /usr/local/lib/systemd/system/buildkit.service
ADD ${URL_RAW_BUILDKIT}/examples/systemd/system/buildkit.socket /usr/local/lib/systemd/system/buildkit.socket
RUN systemctl enable buildkit.service

FROM buildkit AS nerdctl
ARG URL_ARTIFACT_NERDCTL
# install nerdctl
ADD ${URL_ARTIFACT_NERDCTL} /tmp/nerdctl.tar.gz
RUN tar Cxzvvf /usr/local/bin /tmp/nerdctl.tar.gz \
    && rm /tmp/nerdctl.tar.gz

FROM nerdctl AS final
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname