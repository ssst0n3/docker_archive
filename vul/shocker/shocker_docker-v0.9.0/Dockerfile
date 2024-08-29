FROM ssst0n3/docker_archive:ctr_docker-v0.9.0_v0.1.0

COPY busybox-ubuntu-12.04.tar.gz /root/
COPY poc.sh /root/
# capsh
RUN apt-get update && apt-get install -y libcap2-bin