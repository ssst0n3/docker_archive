FROM ssst0n3/docker_archive:pre_operator_v0.1.0
COPY --from=ssst0n3/docker_archive:ubuntu-22.04_runc-1.1.4_v0.1.0 /ubuntu-server-cloudimg.img /

# cloud_init config
COPY cloud.txt cloud.txt
RUN cloud-localds /cloud.img cloud.txt

RUN /init_qemu.expect 
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM ssst0n3/docker_archive:release_basic_ubuntu-20.04
COPY --from=0 /ubuntu-server-cloudimg.img /