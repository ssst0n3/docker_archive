FROM ssst0n3/docker_archive:ctr_ubuntu-12.04_v0.1.0

ADD http://get.docker.io/ubuntu/pool/main/l/lxc-docker-0.7.2/lxc-docker-0.7.2_0.7.2_amd64.deb /tmp/
RUN dpkg -i /tmp/lxc-docker-0.7.2_0.7.2_amd64.deb || apt-get install -f -y
# lxc-net dependency
RUN apt-get update && apt-get install -y net-tools
