FROM ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1_v0.1.1

RUN apt update && apt install -y qemu-system-x86 qemu-utils cloud-image-utils expect libguestfs-tools linux-image-generic && apt clean

# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

COPY init_qemu.expect /init_qemu.expect
RUN /init_qemu.expect 

COPY shrunk.sh /shrunk.sh
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ssst0n3/docker_archive:release_basic_ubuntu-20.04
COPY --from=0 /ubuntu-server-cloudimg.img /
