FROM ssst0n3/docker_archive:build_basic_centos-8-stream
# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

COPY init_qemu.expect /init_qemu.expect
RUN /init_qemu.expect 

RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ssst0n3/docker_archive:release_basic_ubuntu-20.04
COPY --from=0 /ubuntu-server-cloudimg.img /
