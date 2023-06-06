FROM ssst0n3/docker_archive:build_basic_ubuntu-22.04-20220609

# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

COPY init_qemu.expect /init_qemu.expect
RUN /init_qemu.expect

# for shrunk.sh virt-sparsify
RUN apt update && apt install -y libguestfs-tools linux-image-generic && apt clean
COPY shrunk.sh /shrunk.sh
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
COPY --from=0 /ubuntu-server-cloudimg.img /
COPY shrunk.sh /shrunk.sh
COPY init_qemu.expect /init_qemu.expect
COPY start_vm.sh /start_vm.sh
RUN apt update && apt install -y qemu-system-x86 qemu-utils cloud-image-utils expect libguestfs-tools linux-image-generic && apt clean
CMD [ "/start_vm.sh" ]
