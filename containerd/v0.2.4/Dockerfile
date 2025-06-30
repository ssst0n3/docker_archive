# https://github.com/containerd/containerd/blob/v0.2.4/Dockerfile#L58
ARG VERSION_RUNC=1.0.0-rc1
ARG VERSION_CONTAINERD=0.2.4
ARG VERSION_IMAGE=0.2.0
ARG IMAGE_RUNC=ssst0n3/docker_archive:ctr_runc-v${VERSION_RUNC}
ARG URL_ARTIFACT_CONTAINERD=https://github.com/ssst0n3/container-debug-artifacts/releases/download/containerd
# https://github.com/containerd/containerd/blob/v0.2.4/hack/containerd.service
ARG URL_ARTIFACT_SYSTEMD=https://raw.githubusercontent.com/containerd/containerd/refs/tags/v${VERSION_CONTAINERD}/hack/containerd.service

FROM ${IMAGE_RUNC}_v${VERSION_IMAGE}
ARG URL_ARTIFACT_CONTAINERD
ARG URL_ARTIFACT_SYSTEMD
ARG VERSION_CONTAINERD
# install containerd
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/containerd-v${VERSION_CONTAINERD}-debug /usr/local/bin/containerd
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/containerd-shim-v${VERSION_CONTAINERD}-debug /usr/local/bin/containerd-shim
ADD --chmod=755 ${URL_ARTIFACT_CONTAINERD}/ctr-v${VERSION_CONTAINERD}-debug /usr/local/bin/ctr

# config systemd
ADD ${URL_ARTIFACT_SYSTEMD} /usr/local/lib/systemd/system/containerd.service
