# syntax=docker/dockerfile:1-labs
# ================================
# Configuration Variables
# ================================
ARG VERSION_KUBERNETES=1.33.8
ARG VERSION_DLV=1.26.0
ARG VERSION_IMAGE=0.1.0

# ================================
# Internal Variables
# ================================
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_kubernetes-v${VERSION_KUBERNETES}-calico
ARG URL_ARTIFACT_KUBELET_DEBUG=https://github.com/ssst0n3/container-debug-artifacts/releases/download/kubernetes/kubelet-v${VERSION_KUBERNETES}-debug
ARG URL_ARTIFACT_DLV=https://github.com/ssst0n3/container-debug-artifacts/releases/download/dlv/dlv-v${VERSION_DLV}

# ================================
# Build Stages
# ================================
FROM ${BASE_IMAGE}_v${VERSION_IMAGE}
ARG URL_ARTIFACT_KUBELET_DEBUG
ARG URL_ARTIFACT_DLV
ADD --chmod=755 ${URL_ARTIFACT_KUBELET_DEBUG} /usr/local/bin/kubelet.debug
ADD --chmod=755 ${URL_ARTIFACT_DLV} /usr/local/bin/dlv
COPY --chmod=755 debug.sh /usr/local/bin/debug.sh
# back up real kubelet binary
RUN cp /usr/bin/kubelet /usr/local/bin/kubelet.real
