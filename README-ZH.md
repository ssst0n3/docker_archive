# docker archive: 提供大量docker及其组件的镜像

[english version](./README.md)

你可以通过pull容器镜像的形式，来获取特定版本的docker环境，例如docker19.03等。

在你pull下来的镜像中，会有一个qemu，qemu中又会有一个docker 19.03。

是的，这种形式有点像俄罗斯套娃，但对于容器安全研究来说，这种形式确实非常方便。

## 使用说明
你可以在[dockerhub](https://hub.docker.com/repository/docker/ssst0n3/docker_archive/tags?page=1&ordering=last_updated) 上看到所有版本的镜像。

对于每一个版本的docker，我们都会提供两种镜像
* docker in ubuntu in qemu in docker: docker运行在ubuntu操作系统中
* docker in linuxkit in qemu in docker: docker运行在[linuxkit](https://github.com/linuxkit/linuxkit) 操作系统中

### for docker in ubuntu in qemu in docker
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

## 当前支持的版本列表
Check versions provided @ [tags](https://github.com/ssst0n3/docker_archive/tags)

### linuxkit(slim version)
* linuxkit_docker-17.06.0
* linuxkit_docker-19.03.0
    * cannot be used to reproduce CVE-2019-14271 because of static build
* linuxkit_docker-19.03.0-rc3
* linuxkit_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd-1.2.6_runc-1.0.0-rc8
* linuxkit_docker-19.03.14
* linuxkit_docker-20.10.0
* linuxkit_docker-20.10.2
    * alias: cve-2021-21285_slim

### ubuntu
* ubuntu-20.04_docker-ce-17.06.0
* ubuntu-20.04_docker-ce-18.09.0_docker-ce-cli-18.09.0_containerd.io-1.2.6-3_runc-1.0.0-rc8
* ubuntu-20.04_docker-ce-18.09.9_docker-ce-cli-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6
* ubuntu-20.04_docker-ce-19.03.0_docker-ce-cli-19.03.0_containerd.io-1.2.6-3_runc-1.0.0-rc8
    * alias: CVE-2019-14271
* ubuntu-20.04_docker-ce-19.03.1_docker-ce-cli-19.03.1_containerd.io-1.2.6-3_runc-1.0.0-rc8
* ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.6-3_runc-1.0.0-rc8
    * alias: CVE-2019-16884
        * cannot be built by linuxkit, because linux/kernel do not support apparmor
* ubuntu-20.04_docker-ce-19.03.2_docker-ce-cli-19.03.2_containerd.io-1.2.10-3_runc-1.0.0-rc8-dev
* ubuntu-20.04_docker-ce-19.03.5_docker-ce-cli-19.03.5_containerd.io-1.2.6.3_runc-1.0.0-rc8
* ubuntu-20.04_docker-ce-19.03.12_docker-ce-cli-19.03.12_containerd.io-1.2.13_runc-1.0.0-rc10
* ubuntu-20.04_docker-ce-19.03.13_docker-ce-cli-19.03.13_containerd.io-1.3.7_runc-1.0.0-rc10
* ubuntu-20.04_docker-ce-19.03.14_docker-ce-cli-19.03.14_containerd.io-1.3.9_runc-1.0.0-rc10
* ubuntu-20.04_docker-ce-19.03.15_docker-ce-cli-19.03.15_containerd.io-1.4.3_runc-1.0.0-rc92
* ubuntu-20.04_docker-ce-20.10.0_docker-ce-cli-20.10.0_containerd.io-1.4.3_runc-1.0.0-rc92
* ubuntu-20.04_docker-ce-20.10.1_docker-ce-cli-20.10.1_containerd.io-1.4.3_runc-1.0.0-rc92
* ubuntu-20.04_docker-ce-20.10.2_docker-ce-cli-20.10.2_containerd.io-1.4.3_runc-1.0.0-rc92
    * alias: cve-2021-21285
* ubuntu-20.04_docker-ce-20.10.3_docker-ce-cli-20.10.3_containerd.io-1.4.3_runc-1.0.0-rc92
* ubuntu-20.04_docker-ce-20.10.6_docker-ce-cli-20.10.6_containerd.io-1.4.4_runc-1.0.0-rc93
