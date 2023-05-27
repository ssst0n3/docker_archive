FROM ssst0n3/docker_archive:build_basic_ubuntu-20.04

# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

COPY init_qemu.expect /init_qemu.expect
RUN /init_qemu.expect

# for shrunk.sh virt-sparsify
RUN apt update && apt install -y libguestfs-tools linux-image-generic && apt clean
COPY shrunk.sh /shrunk.sh
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
COPY --from=0 /ubuntu-server-cloudimg.img /
COPY shrunk.sh /shrunk.sh
COPY init_qemu.expect /init_qemu.expect
RUN apt update && apt install -y qemu-system-x86 qemu-utils cloud-image-utils expect openssh-client libguestfs-tools linux-image-generic libguestfs-tools linux-image-generic && apt clean

