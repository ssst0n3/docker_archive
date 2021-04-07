# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## How-To
See all versions of images [here](https://hub.docker.com/repository/docker/ssst0n3/docker_archive/tags?page=1&ordering=last_updated)

### for docker in ubuntu in qemu in docker
Pull one and run it
```
$ docker network create test
$ docker run --network=test -d -p 2222:22 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92
$ ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
...
```

### for docker in linuxkit in qemu in docker
```
docker run -ti ssst0n3/docker_archive:linuxkit_docker-19.03.0
// wait container start up
docker version
```

## tag template
{operating system version}_{docker and it's components version}

## version
Check versions provided @ [tags](https://github.com/ssst0n3/docker_archive/tags)

* linuxkit_docker-19.03.0
    * cannot be used to reproduce CVE-2019-14271 because of static build
* ubuntu-20.04_docker-ce-19.03.0_docker-ce-cli-19.03.0_containerd.io-1.2.6-3_runc-1.0.0-rc8
  * alias: CVE-2019-14271
* ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.10-3_runc-1.0.0-rc8-dev
* ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.6-3_runc-1.0.0-rc8
  * alias: CVE-2019-16884
    * cannot be built by linuxkit, because linux/kernel do not support apparmor
* ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92


## TODO:
use linuxkit to build a slim linux