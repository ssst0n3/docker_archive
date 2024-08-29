FROM ssst0n3/docker_archive:ctr_ubuntu-12.04_v0.1.0

ADD http://get.docker.io/ubuntu/pool/main/l/lxc-docker-0.9.0/lxc-docker-0.9.0_0.9.0_amd64.deb /tmp/
RUN dpkg -i /tmp/lxc-docker-0.9.0_0.9.0_amd64.deb || apt-get install -f -y
# lxc, lxc-net dependency
RUN apt-get update && apt-get install -y lxc net-tools
RUN sed -i 's/DOCKER_OPTS=/DOCKER_OPTS="-e lxc"/g' /etc/init/docker.conf