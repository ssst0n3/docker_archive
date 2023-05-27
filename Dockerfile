FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
COPY shrunk.sh /shrunk.sh
COPY init_qemu.expect /init_qemu.expect
COPY start_vm.sh /start_vm.sh
RUN apt update && apt install -y qemu-system-x86 qemu-utils cloud-image-utils expect libguestfs-tools linux-image-generic && apt clean