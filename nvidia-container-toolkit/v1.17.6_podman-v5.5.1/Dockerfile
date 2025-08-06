ARG HOSTNAME=nvidia-container-toolkit-1-17-6-podman-5-5-1
ARG VERSION_NCT=1.17.6
ARG VERSION_NCT_PKG=${VERSION_NCT}-1
ARG VERSION_FAKE_NVIDIA=0.7.3-rc.2
ARG VERSION_PODMAN=5.5.1
ARG VERSION_KERNEL=5.14.0-601.el9.x86_64
ARG VERSION_NVIDIA_DRIVER=575.57.08
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_podman-v${VERSION_PODMAN}
ARG VERSION_IMAGE=0.1.0
ARG URL_ARTIFACT_FAKE=https://github.com/ssst0n3/fake-nvidia/archive/refs/tags/v${VERSION_FAKE_NVIDIA}.tar.gz
ARG URL_ARTIFACT_DRIVER=https://us.download.nvidia.com/tesla/${VERSION_NVIDIA_DRIVER}/NVIDIA-Linux-x86_64-${VERSION_NVIDIA_DRIVER}.run

# https://gitlab.com/nvidia/container-images/driver/-/blob/master/ubuntu18.04/Dockerfile#L48
FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS driver
ARG URL_ARTIFACT_DRIVER
ADD --chmod=755 ${URL_ARTIFACT_DRIVER} /tmp/nvidia-driver.run
RUN /tmp/nvidia-driver.run --silent \
    --no-kernel-module \
    --install-compat32-libs

FROM driver AS fake-nvidia
ARG VERSION_FAKE_NVIDIA
ARG VERSION_KERNEL
ARG VERSION_NVIDIA_DRIVER
ARG URL_ARTIFACT_FAKE
ADD ${URL_ARTIFACT_FAKE} /tmp/fake-nvidia.tar.gz
RUN dnf install -y \
        make \
        kernel-${VERSION_KERNEL} \
        kernel-devel-${VERSION_KERNEL}
RUN tar -xzf /tmp/fake-nvidia.tar.gz -C /tmp && \
    mv /tmp/fake-nvidia-${VERSION_FAKE_NVIDIA} /usr/local/fake-nvidia && \
    rm -rf /tmp/fake-nvidia.tar.gz && \
    cd /usr/local/fake-nvidia && \
    KERNEL_RELEASE=${VERSION_KERNEL} NVIDIA_DRIVER_VERSION=${VERSION_NVIDIA_DRIVER} make install

FROM fake-nvidia AS nvidia-container-toolkit
ARG VERSION_NCT_PKG
RUN curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
    tee /etc/yum.repos.d/nvidia-container-toolkit.repo && \
    sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/nvidia-container-toolkit.repo && \
    dnf install -y \
      nvidia-container-toolkit-${VERSION_NCT_PKG} \
      nvidia-container-toolkit-base-${VERSION_NCT_PKG} \
      libnvidia-container-tools-${VERSION_NCT_PKG} \
      libnvidia-container1-${VERSION_NCT_PKG}

FROM nvidia-container-toolkit
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname
