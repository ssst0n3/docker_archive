ARG HOSTNAME=nvidia-container-toolkit-1-17-8
ARG VERSION_NCT=1.17.8
ARG VERSION_NCT_PKG=${VERSION_NCT}-1
ARG VERSION_FAKE_NVIDIA=0.7.2
ARG VERSION_DOCKER=28.2.0
ARG VERSION_KERNEL=6.8.0-71-generic
ARG VERSION_NVIDIA_DRIVER=575.57.08
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_docker-v${VERSION_DOCKER}
ARG VERSION_IMAGE=0.1.0
ARG URL_ARTIFACT_FAKE=https://github.com/ssst0n3/fake-nvidia/archive/refs/tags/v${VERSION_FAKE_NVIDIA}.tar.gz
ARG URL_ARTIFACT_DRIVER=https://us.download.nvidia.com/tesla/${VERSION_NVIDIA_DRIVER}/NVIDIA-Linux-x86_64-${VERSION_NVIDIA_DRIVER}.run

# https://gitlab.com/nvidia/container-images/driver/-/blob/master/ubuntu18.04/Dockerfile#L48
FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS driver
ARG URL_ARTIFACT_DRIVER
ADD --chmod=755 ${URL_ARTIFACT_DRIVER} /tmp/nvidia-driver.run
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y \
        # Fix: Unable to find the module utility modprobe
        kmod \
        # Fix: Unable to find a suitable destination to install 32-bit compatibility libraries
        libc6:i386 \
        # Fix: WARNING: Unable to determine the path to install the libglvnd EGL vendor library config files. 
        # Check that you have pkg-config and the libglvnd development libraries installed, 
        # or specify a path with --glvnd-egl-config-path.
        pkg-config \
        # Fix: WARNING: This NVIDIA driver package includes Vulkan components, but no Vulkan ICD loader was detected on this system. 
        # The NVIDIA Vulkan ICD will not function without the loader. Most distributions package the Vulkan loader; 
        # try installing the "vulkan-loader", "vulkan-icd-loader", or "libvulkan1" package.
        libglvnd-dev 
RUN /tmp/nvidia-driver.run --silent \
    --no-kernel-module \
    --install-compat32-libs

FROM driver AS fake-nvidia
ARG VERSION_FAKE_NVIDIA
ARG VERSION_KERNEL
ARG VERSION_NVIDIA_DRIVER
ARG URL_ARTIFACT_FAKE
ADD ${URL_ARTIFACT_FAKE} /tmp/fake-nvidia.tar.gz
RUN apt update && apt install -y build-essential linux-headers-${VERSION_KERNEL}
RUN tar -xzf /tmp/fake-nvidia.tar.gz -C /tmp && \
    mv /tmp/fake-nvidia-${VERSION_FAKE_NVIDIA} /usr/local/fake-nvidia && \
    rm -rf /tmp/fake-nvidia.tar.gz && \
    cd /usr/local/fake-nvidia && \
    KERNEL_RELEASE=${VERSION_KERNEL} NVIDIA_DRIVER_VERSION=${VERSION_NVIDIA_DRIVER} make install

FROM fake-nvidia AS nvidia-container-toolkit
ARG VERSION_NCT_PKG
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
    gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
RUN apt-get update && \
    apt-get install -y \
      nvidia-container-toolkit=${VERSION_NCT_PKG} \
      nvidia-container-toolkit-base=${VERSION_NCT_PKG} \
      libnvidia-container-tools=${VERSION_NCT_PKG} \
      libnvidia-container1=${VERSION_NCT_PKG}
RUN nvidia-ctk runtime configure --runtime=docker

FROM nvidia-container-toolkit
ARG HOSTNAME
RUN echo ${HOSTNAME} > /etc/hostname
