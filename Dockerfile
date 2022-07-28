FROM ubuntu:20.04
ADD https://cloud.centos.org/centos/8-stream/x86_64/images/CentOS-Stream-GenericCloud-8-20210603.0.x86_64.qcow2 /ubuntu-server-cloudimg.img

# install qemu, cloud-localds
# RUN sed -i "s@http://.*.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
RUN apt-get update && apt-get install -y qemu-system-x86 qemu-utils cloud-image-utils expect openssh-client && apt-get clean
RUN qemu-img resize ubuntu-server-cloudimg.img 10G
COPY init_qemu.expect /
COPY shrunk.sh /