FROM ssst0n3/docker_archive:ctr_ubuntu-16.04_v0.1.0

# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY precise.list /etc/apt/sources.list.d/
COPY trusty.list /etc/apt/sources.list.d/
# RUN apt-get update && apt-get install --no-install-recommends -y lxc=2.0.0-0ubuntu2  lxc-common=2.0.0-0ubuntu2 liblxc1=2.0.0-0ubuntu2 lxc1=2.0.0-0ubuntu2 python3-lxc=2.0.0-0ubuntu2
# RUN apt-get update && apt-get install --no-install-recommends -y lxc=0.7.5-3ubuntu70 apparmor=2.7.102-0ubuntu3 lxc-docker-0.7.1

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
RUN apt-get update && apt-get install --no-install-recommends -y lxc=0.7.5-3ubuntu70 apparmor=2.7.102-0ubuntu3 lxc-docker-0.7.1
# RUN apt-get update && apt-get install --no-install-recommends -y lxc-docker-0.7.1
RUN systemctl enable docker
