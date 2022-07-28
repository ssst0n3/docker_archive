FROM ubuntu:20.04
ADD https://cloud-images.ubuntu.com/xenial/20211001/xenial-server-cloudimg-amd64-disk1.img /ubuntu-server-cloudimg.img
# ADD https://repo.huaweicloud.com/ubuntu-cloud-images/releases/16.04/release-20211001/ubuntu-16.04-server-cloudimg-amd64-disk1.img /ubuntu-server-cloudimg.img
# ADD https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img /ubuntu-server-cloudimg.img
# COPY ./ubuntu-20.04-server-cloudimg-amd64.img ubuntu-20.04-server-cloudimg-amd64.img

# install qemu, cloud-localds
RUN sed -i "s@http://.*.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
RUN apt-get update && apt-get install -y qemu-system-x86 qemu-utils cloud-image-utils expect openssh-client && apt-get clean
RUN qemu-img resize ubuntu-server-cloudimg.img 10G
COPY init_qemu.expect /
COPY shrunk.sh /