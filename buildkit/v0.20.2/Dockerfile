ARG VERSION_BUILDKIT=0.20.2
# https://github.com/moby/buildkit/blob/v0.20.2/Dockerfile#L3
ARG VERSION_RUNC=1.2.5
ARG IMAGE_RUNC=ssst0n3/docker_archive:ctr_runc-v${VERSION_RUNC}_v0.2.0
ARG URL_ARTIFACT_BUILDKIT=https://github.com/moby/buildkit/releases/download/v${VERSION_BUILDKIT}/buildkit-v${VERSION_BUILDKIT}.linux-amd64.tar.gz

FROM ${IMAGE_RUNC} AS buildkit
ARG VERSION_BUILDKIT
ARG URL_ARTIFACT_BUILDKIT
# install buildkit
# https://github.com/containerd/nerdctl/blob/v2.0.4/docs/build.md#rootful
ADD ${URL_ARTIFACT_BUILDKIT} /tmp/buildkit.tar.gz
RUN tar Cxzvvf /usr/local/ /tmp/buildkit.tar.gz \
    && rm /tmp/buildkit.tar.gz
# config systemd
ADD https://raw.githubusercontent.com/moby/buildkit/refs/tags/v${VERSION_BUILDKIT}/examples/systemd/system/buildkit.service /usr/local/lib/systemd/system/buildkit.service
ADD https://raw.githubusercontent.com/moby/buildkit/refs/tags/v${VERSION_BUILDKIT}/examples/systemd/system/buildkit.socket /usr/local/lib/systemd/system/buildkit.socket
RUN systemctl enable buildkit.service
