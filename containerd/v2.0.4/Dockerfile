# https://github.com/containerd/containerd/blob/v2.0.4/script/setup/runc-version
ARG RUNC_VERSION=1.2.5
ARG CONTAINERD_VERSION=2.0.4
ARG RUNC_IMAGE=ssst0n3/docker_archive:ctr_runc-v${RUNC_VERSION}_v0.2.0
ARG URL_CONTAINERD_ARTIFACT=https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/containerd-${CONTAINERD_VERSION}-linux-amd64.tar.gz

FROM ${RUNC_IMAGE} AS build
ARG URL_CONTAINERD_ARTIFACT
ARG CONTAINERD_VERSION
# install containerd
ADD ${URL_CONTAINERD_ARTIFACT} /tmp/containerd.tar.gz
RUN tar Cxzvf /usr/local /tmp/containerd.tar.gz \
    && rm /tmp/containerd.tar.gz

# config systemd
ADD https://raw.githubusercontent.com/containerd/containerd/refs/tags/v${CONTAINERD_VERSION}/containerd.service /usr/local/lib/systemd/system/containerd.service

# squash
FROM scratch AS release
COPY --from=build / /