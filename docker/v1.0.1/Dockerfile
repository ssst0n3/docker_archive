FROM ssst0n3/docker_archive:ctr_ubuntu-14.04_v0.1.0

# ADD http://get.docker.io/ubuntu/pool/main/l/lxc-docker-1.0.0/lxc-docker-1.0.0_1.0.0_amd64.deb /tmp/lxc-docker.deb
# RUN dpkg -i /tmp/lxc-docker.deb || echo 'pass'
# # install dependencies
# RUN apt-get update && apt-get install -f -y
# # install apparmor
# RUN apt-get install -y apparmor
ADD http://launchpadlibrarian.net/182886743/docker.io_1.0.1~dfsg1-0ubuntu1~ubuntu0.14.04.1_amd64.deb /tmp/docker.io.deb
RUN dpkg -i /tmp/docker.io.deb || echo 'pass'
# install dependencies
RUN apt-get update && apt-get install -f -y