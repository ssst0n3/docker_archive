ARG HOSTNAME=nvidia-container-toolkit-1-12-0
ARG VERSION_NCT=1.12.0
ARG VERSION_NCT_PKG=${VERSION_NCT}-1
ARG VERSION_FAKE_NVIDIA=0.7.1
ARG VERSION_DOCKER=23.0.0
ARG VERSION_KERNEL=5.15.0-151-generic
ARG VERSION_NVIDIA_DRIVER=575.57.08
ARG VERSION_CUDA=12.9
ARG IMAGE_CUDA=nvidia/cuda:12.9.1-base-ubuntu22.04
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}
ARG VERSION_IMAGE=0.1.0
ARG URL_ARTIFACT_FAKE=https://github.com/ssst0n3/fake-nvidia/archive/refs/tags/v${VERSION_FAKE_NVIDIA}.tar.gz

FROM ${IMAGE_CUDA} AS cuda
FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS builder
ARG VERSION_KERNEL
RUN apt update && \
    apt install -y build-essential linux-headers-${VERSION_KERNEL}

FROM builder AS fake-nvidia
ARG VERSION_FAKE_NVIDIA
ARG VERSION_KERNEL
ARG VERSION_NVIDIA_DRIVER
ARG VERSION_CUDA
ARG URL_ARTIFACT_FAKE
ADD ${URL_ARTIFACT_FAKE} /tmp/fake-nvidia.tar.gz
RUN tar -xzf /tmp/fake-nvidia.tar.gz -C /tmp && \
    mv /tmp/fake-nvidia-${VERSION_FAKE_NVIDIA} /usr/local/fake-nvidia && \
    rm -rf /tmp/fake-nvidia.tar.gz && \
    cd /usr/local/fake-nvidia && \
    KERNEL_RELEASE=${VERSION_KERNEL} NVIDIA_DRIVER_VERSION=${VERSION_NVIDIA_DRIVER} make install
COPY --from=cuda /usr/local/cuda-${VERSION_CUDA}/compat/libcuda.so.${VERSION_NVIDIA_DRIVER} /usr/lib/x86_64-linux-gnu/

FROM fake-nvidia AS nvidia-container-toolkit
ARG VERSION_NCT_PKG
# https://web.archive.org/web/20230627162323/https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
    gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/experimental/ubuntu22.04/libnvidia-container.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
RUN apt-get update && \
    apt-get install -y \
      nvidia-container-toolkit=${VERSION_NCT_PKG} \
      nvidia-container-toolkit-base=${VERSION_NCT_PKG} \
      libnvidia-container-tools=${VERSION_NCT_PKG} \
      libnvidia-container1=${VERSION_NCT_PKG}
RUN mkdir -p /etc/docker && \
    nvidia-ctk runtime configure --runtime=docker

FROM nvidia-container-toolkit
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname
