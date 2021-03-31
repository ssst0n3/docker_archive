FROM ssst0n3/docker_archive:release_basic_alpine-3.13.3

COPY docker.qcow2 /
COPY qemu.sh /qemu.sh

CMD [ "/qemu.sh" ]
