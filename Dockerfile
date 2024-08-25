FROM ubuntu:20.04
# ADD http://cloud-images-archive.ubuntu.com/releases/precise/release-20170502/ubuntu-12.04-server-cloudimg-amd64-disk1.img /ubuntu-server-cloudimg.img
COPY ubuntu-12.04-server-cloudimg-amd64-disk1.img /ubuntu-server-cloudimg.img

# install qemu, cloud-localds
RUN apt-get update && apt-get install -y qemu-system-x86 qemu-utils cloud-image-utils expect openssh-client && apt-get clean
RUN qemu-img resize ubuntu-server-cloudimg.img 10G
COPY init_qemu.expect /
COPY shrunk.sh /
