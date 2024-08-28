FROM ssst0n3/docker_archive:ctr_ubuntu-12.04_v0.1.0

# gnutls_handshake bug
# RUN apt-get update && apt-get install -y apt-transport-https ca-certificates
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
# RUN sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
# RUN apt-get update && apt-get install -y lxc-docker-0.7.1

ADD http://get.docker.io/ubuntu/pool/main/l/lxc-docker-0.7.1/lxc-docker-0.7.1_0.7.1_amd64.deb /tmp/
RUN dpkg -i /tmp/lxc-docker-0.7.1_0.7.1_amd64.deb || apt-get install -f -y
# lxc-net dependency
RUN apt-get update && apt-get install -y net-tools
