# docker archive: Provide many versions of images of docker and docker's components

[中文文档](./README-ZH.md)

You can get specify version of docker such as docker 19.03 by pull a container image.

There will be a qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## List of currently supported versions
Check versions provided @ [tags](https://github.com/ssst0n3/docker_archive/tags)

See all images listed in [images.md](./images.md) or [dockerhub](https://hub.docker.com/repository/docker/ssst0n3/docker_archive/tags?page=1&ordering=last_updated).

## How-To

To each version docker, we will provide two types of images:
* docker in ubuntu in qemu in docker
* docker in [linuxkit](https://github.com/linuxkit/linuxkit) in qemu in docker

### for docker in ubuntu in qemu in docker
Pull one and run it

**ssh**
```
$ docker network create test
$ docker run --network=test -d -p 2222:22 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92
$ ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
...
```

**tty**
```
docker run -tid --name archive ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92
docker attach --detach-keys="ctrl-x" archive
```

**kvm**
```
docker run -ti --dev /dev/kvm ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1 /start_vm.sh -enable-kvm
```

### for docker in linuxkit in qemu in docker
```
docker run -ti ssst0n3/docker_archive:linuxkit_docker-19.03.0
// wait container start up
docker version
```

## tag template
{operating system version}_{docker and it's components version}

## Known Issues

### ssh stuck https://github.com/ssst0n3/docker_archive/issues/10

ssh will be stuck when running some images, but some won't.

I don't known the exactly reason. If you met this issue, try this command instead

```
docker network create test
docker run --network=test ...
```

### window size so small

use ssh or execute commands below in the vm
```
apt install -y xterm && resize
```
