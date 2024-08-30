FROM ssst0n3/docker_archive:ctr_ubuntu-14.04_v0.1.0

ADD http://get.docker.io/ubuntu/pool/main/l/lxc-docker-0.12.0/lxc-docker-0.12.0_0.12.0_amd64.deb /tmp/lxc-docker.deb
RUN dpkg -i /tmp/lxc-docker.deb || echo 'pass'
# install dependencies
RUN apt-get update && apt-get install -f -y
# install apparmor, lxc
RUN apt-get update && apt-get install -y apparmor lxc
RUN sed -i 's/DOCKER_OPTS=/DOCKER_OPTS="-e lxc"/g' /etc/init/docker.conf