FROM ssst0n3/docker_archive:pre_ubuntu-16.04_v0.1.2

# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

RUN /init_qemu.expect 
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ssst0n3/docker_archive:release_basic_ubuntu-16.04
COPY --from=0 /ubuntu-server-cloudimg.img /
