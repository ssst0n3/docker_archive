FROM ssst0n3/docker_archive:ctr_ubuntu-14.04_v0.1.0

ADD http://get.docker.io/ubuntu/pool/main/l/lxc-docker-0.11.1/lxc-docker-0.11.1_0.11.1_amd64.deb /tmp/
RUN dpkg -i /tmp/lxc-docker-0.11.1_0.11.1_amd64.deb || echo 'pass'
# prevent sparse file
RUN apt-get update && apt-get install -f -y && \
    rm /var/lib/docker/devicemapper/devicemapper/data && \
    rm /var/lib/docker/devicemapper/devicemapper/metadata
# install apparmor
RUN apt-get install -y apparmor
# lxc, lxc-net dependency
RUN apt-get update && apt-get install -y lxc net-tools
RUN sed -i 's/DOCKER_OPTS=/DOCKER_OPTS="-e lxc"/g' /etc/init/docker.conf