FROM ssst0n3/docker_archive:release_basic_alpine-3.13.3

ADD https://docker-archive-iso.obs.cn-southwest-2.myhuaweicloud.com/linuxkit_docker-19.03.0.qcow2 /docker.qcow2
COPY qemu.sh /qemu.sh

CMD [ "/qemu.sh" ]
