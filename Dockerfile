FROM ssst0n3/docker_archive:ubuntu-22.04_runc-1.1.4

RUN apt-get update && apt-get install -y qemu-system-x86 qemu-utils cloud-image-utils expect openssh-client && apt-get clean

# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

COPY enable_cloud-init.expect /enable_cloud-init.expect
RUN /enable_cloud-init.expect

COPY init_qemu.expect /init_qemu.expect
RUN /init_qemu.expect

COPY shrunk.sh /shrunk.sh
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ssst0n3/docker_archive:release_basic_ubuntu-20.04
COPY --from=0 /ubuntu-server-cloudimg.img /
