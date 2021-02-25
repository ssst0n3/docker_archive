FROM ubuntu:20.04
ADD https://repo.huaweicloud.com/ubuntu-cloud-images/releases/20.04/release-20201201/ubuntu-20.04-server-cloudimg-amd64.img /ubuntu-server-cloudimg.img
# ADD http://cloud-images.ubuntu.com/hirsute/current/hirsute-server-cloudimg-amd64.img /ubuntu-server-cloudimg.img
# COPY ./ubuntu-20.04-server-cloudimg-amd64.img ubuntu-20.04-server-cloudimg-amd64.img

# install qemu, cloud-localds
# RUN sed -i "s@http://*.archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
RUN apt-get update && apt-get install -y qemu-system-x86 qemu-utils cloud-image-utils expect openssh-client && apt-get clean
RUN qemu-img resize ubuntu-server-cloudimg.img 10G
