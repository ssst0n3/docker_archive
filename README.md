# docker archive: Provide many versions of images of container's components

See all images listed in [dockerhub](https://hub.docker.com/repository/docker/ssst0n3/docker_archive/tags?page=1&ordering=last_updated).

## How-To

### 1. quick-start

```shell
$ git clone https://github.com/ssst0n3/docker_archive
$ cd docker_archive/docker/v28.1.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           28.1.1
 API version:       1.49
 Go version:        go1.23.8
 Git commit:        4eba377
 Built:             Fri Apr 18 09:52:14 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.1.1
  API version:      1.49 (minimum version 1.24)
  Go version:       go1.23.8
  Git commit:       01f442b
  Built:            Fri Apr 18 09:52:14 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.27
  GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
 runc:
  Version:          1.2.5
  GitCommit:        v1.2.5-0-g59923ef
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

### 2. install built-in ssh config

```shell
$ ./script/install_ssh_config.sh
$ ssh docker-v28.1.1
root@localhost:~# docker version
...
```

## Images

### vul

| tag | version | alias | note |
| --- | --- | --- | --- |
| [cve-2025-1974](./vul/cve-2025-1974/) | v0.1.0 | ingress-nginx-v1.11.3 | |
| [shocker_docker-v0.7.1](./vul/shocker/shocker_docker-v0.7.1/) | v0.1.0 | | lxc execdriver |
| [shocker_docker-v0.7.2](./vul/shocker/shocker_docker-v0.7.2/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [shocker_docker-v0.9.0](./vul/shocker/shocker_docker-v0.9.0/) | v0.1.0 | | native execdriver |
| [shocker_docker-v0.9.0-lxc](./vul/shocker/shocker_docker-v0.9.0-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [shocker_docker-v0.11.1](./vul/shocker/shocker_docker-v0.11.1/) | v0.1.0 | | native execdriver |
| [shocker_docker-v0.11.1-lxc](./vul/shocker/shocker_docker-v0.11.1-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [shocker_docker-v0.12.0](./vul/shocker/shocker_docker-v0.12.0/) | v0.1.0 | | native execdriver, fixed |
| [shocker_docker-v0.12.0-lxc](./vul/shocker/shocker_docker-v0.12.0-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [shocker_docker-v1.0.0-lxc](./vul/shocker/shocker_docker-v1.0.0-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [shocker_docker-v1.0.1-lxc](./vul/shocker/shocker_docker-v1.0.1-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [shocker_docker-v26.1.4](./vul/shocker/shocker_docker-v26.1.4/) | v0.1.0 | | capadd |

### issue

| tag | version | alias |
| --- | --- | --- |
| [runc-issue-4047_commit-a6f4081](./issue/runc-issue-4047_commit-a6f4081/) | v0.1.0 |
| [runc-issue-4047_commit-ab3cd8d](./issue/runc-issue-4047_commit-ab3cd8d/) | v0.1.0 |
| [runc-issue-4047_commit-7396ca9](./issue/runc-issue-4047_commit-7396ca9/) | v0.1.0 |
| [runc-pr-3825_commit-7d09ba1](./issue/runc-pr-3825_commit-7d09ba1/) | v0.1.0 |

### ingress-nginx

| tag | version | alias | note |
| --- | --- | --- | --- |
| [ingress-nginx-v1.11.4](./ingress-nginx/v1.11.4/) | v0.1.0 |  |  |
| [ingress-nginx-v1.11.3](./ingress-nginx/v1.11.3/) | v0.1.0 | cve-2025-1974 |  |

### kubenertes

| tag | version | alias | note |
| --- | --- | --- | --- |
| [kubernetes-v1.32.3-calico](./kubernetes/v1.32.3-calico/) | v0.2.0 | |  |
| [kubernetes-v1.32.3](./kubernetes/v1.32.3/) | v0.2.0 | |  |
| [kubernetes-v1.32.2-calico](./kubernetes/v1.32.2-calico/) | v0.2.0 | |  |
| [kubernetes-v1.32.2](./kubernetes/v1.32.2/) | v0.2.0 | |  |

### docker

| tag | version | alias | note |
| --- | --- | --- | --- |
| [docker-v28.0.4_centos-stream9_runc-v1.2.5-debug](./docker/v28.0.4_centos-stream9_runc-v1.2.5-debug/) | v0.1.0 |
| [docker-v28.0.4_centos-stream9](./docker/v28.0.4_centos-stream9/) | v0.1.0 |
| [docker-v28.0.4-debug](./docker/v28.0.4-debug/) | v0.1.0 |
| [docker-v28.0.4](./docker/v28.0.4/) | v0.1.0 |
| [docker-v28.0.0](./docker/v28.0.0/) | v0.1.0 |
| [docker-v27.5.1](./docker/v27.5.1/) | v0.1.0 |
| [docker-v27.1.0](./docker/v27.1.0/) | v0.1.0 |
| [ubuntu-22.04_docker-v26.1.4](./docker/v26.1.4/) | v0.1.0 |
| [ubuntu-22.04_docker-v23.0.6](./docker/v23.0.6/) | v0.1.0 |
| [ubuntu-18.04_docker-v23.0.6_aufs](./docker/ubuntu-18.04_docker-v23.0.6_aufs/) | v0.1.0 |
| [docker-v1.0.1-lxc](./docker/v1.0.1-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [docker-v1.0.1](./docker/v1.0.1/) | v0.1.0 | | native execdriver |
| [docker-v1.0.0-lxc](./docker/v1.0.0-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [docker-v1.0.0](./docker/v1.0.0/) | v0.1.0 | | native execdriver |
| [docker-v0.12.0-lxc](./docker/v0.12.0-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [docker-v0.12.0](./docker/v0.12.0/) | v0.1.0 | | native execdriver |
| [docker-v0.11.1-lxc](./docker/v0.11.1-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [docker-v0.11.1](./docker/v0.11.1/) | v0.1.0 | | native execdriver |
| [docker-v0.9.0-lxc](./docker/v0.9.0-lxc/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [docker-v0.9.0](./docker/v0.9.0/) | v0.1.0 | | native execdriver |
| [docker-v0.7.2](./docker/v0.7.2/) | v0.1.0 | | lxc(dockerinit) execdriver |
| [docker-v0.7.1](./docker/v0.7.1/) | v0.1.0 | | lxc execdriver |

### podman

| tag | version | alias |
| --- | --- | --- |
| [podman-v5.4.0](./podman/v5.4.0/) | v0.1.0 |

### nerdctl

| tag | version | alias |
| --- | --- | --- |
| [nerdctl-v2.0.4_runc-v1.2.5-debug](./nerdctl/v2.0.4_runc-v1.2.5-debug/) | v0.1.0 |
| [nerdctl-v2.0.4](./nerdctl/v2.0.4/) | v0.1.0 |

### containerd

| tag | version | alias |
| --- | --- | --- |
| [containerd-v2.0.4-fuse-overlayfs](./containerd/v2.0.4-fuse-overlayfs/) | v0.1.0 |
| [containerd-v2.0.4](./containerd/v2.0.4/) | v0.1.0 |
| [containerd-v2.0.3](./containerd/v2.0.3/) | v0.2.0 |
| [containerd-v2.0.2](./containerd/v2.0.2/) | v0.1.0 |
| [ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16](./containerd/v1.7.16/) | v0.1.0 |
| [containerd-v1.3.8](./containerd/v1.3.8/) | v0.1.0 |

### buildkit

| tag | version | alias | note |
| --- | --- | --- | --- |
| [buildkit-v0.20.2](./buildkit/v0.20.2/) | v0.1.0 |

### runc

| tag | version | alias | note |
| --- | --- | --- | --- |
| [runc-v1.2.6](./runc/v1.2.6/) | v0.1.0 |
| [runc-v1.2.5](./runc/v1.2.5/) | v0.2.0 |
| [runc-v1.2.4](./runc/v1.2.4/) | v0.1.0 |
| [runc-v1.2.3](./runc/v1.2.3/) | v0.1.0 |
| [runc-v1.2.2](./runc/v1.2.2/) | v0.1.0 |
| [runc-v1.2.1](./runc/v1.2.1/) | v0.1.0 |
| [runc-v1.2.0](./runc/v1.2.0/) | v0.1.0 |
| [runc-v1.2.0-rc.3](./runc/v1.2.0-rc.3/) | v0.1.0 |
| [runc-v1.2.0-rc.2](./runc/v1.2.0-rc.2/) | v0.1.0 |
| [runc-v1.2.0-rc.1](./runc/v1.2.0-rc.1/) | v0.1.0 |
| [runc-v1.1.0-a6f4081](./runc/v1.1.0-a6f4081/) | v0.1.0 | | PR#4102 |
| [runc-v1.1.0-ab3cd8d](./runc/v1.1.0-ab3cd8d/) | v0.1.0 | | PR#4102 |
| [runc-v1.1.0-7396ca9](./runc/v1.1.0-7396ca9/) | v0.1.0 | | PR#4102 |
| [runc-v1.1.0-d3d7f7d](./runc/v1.1.0-d3d7f7d/) | v0.1.0 | | PR#4102 |
| [runc-v1.1.0-7d09ba1](./runc/v1.1.0-7d09ba1/) | v0.1.0 | | PR#3825 |
| [runc-v1.1.15](./runc/v1.1.15/) | v0.1.0 |
| [runc-v1.1.14](./runc/v1.1.14/) | v0.1.0 |
| [runc-v1.1.13](./runc/v1.1.13/) | v0.1.0 |
| [ubuntu-22.04_runc-v1.1.12](./runc/v1.1.12/) | v0.2.0 |
| [runc-v1.1.11](./runc/v1.1.11/) | v0.1.0 |
| [runc-v1.1.10](./runc/v1.1.10/) | v0.1.0 |
| [runc-v1.1.9](./runc/v1.1.9/) | v0.1.0 | | ubuntu 22.04 |
| [ubuntu-20.04_runc-v1.1.9](./runc/ubuntu-20.04_runc-v1.1.9/) | v0.1.0 |
| [runc-v1.1.8](./runc/v1.1.8/) | v0.1.0 |
| [runc-v1.1.7](./runc/v1.1.7/) | v0.1.0 |
| [runc-v1.1.6](./runc/v1.1.6/) | v0.1.0 |
| [runc-v1.1.5](./runc/v1.1.5/) | v0.1.0 |
| [runc-v1.1.4](./runc/v1.1.4/) | v0.1.0 |
| [runc-v1.1.3](./runc/v1.1.3/) | v0.1.0 |
| [runc-v1.1.2](./runc/v1.1.2/) | v0.1.0 |
| [runc-v1.1.1](./runc/v1.1.1/) | v0.1.0 |
| [runc-v1.1.0](./runc/v1.1.0/) | v0.1.0 |
| [runc-v1.1.0-rc.1](./runc/v1.1.0-rc.1/) | v0.1.0 |
| [runc-v1.0.3](./runc/v1.0.3/) | v0.1.0 |
| [runc-v1.0.2](./runc/v1.0.2/) | v0.1.0 |
| [runc-v1.0.1](./runc/v1.0.1/) | v0.1.0 |
| [runc-v1.0.0](./runc/v1.0.0/) | v0.1.0 |
| [runc-v1.0.0-rc95](./runc/v1.0.0-rc95/) | v0.1.0 |
| [runc-v1.0.0-rc94](./runc/v1.0.0-rc94/) | v0.1.0 |
| [runc-v1.0.0-rc93](./runc/v1.0.0-rc93/) | v0.1.0 |
| [runc-v1.0.0-rc92](./runc/v1.0.0-rc92/) | v0.1.0 |
| [runc-v1.0.0-rc91](./runc/v1.0.0-rc91/) | v0.1.0 |
| [runc-v1.0.0-rc90](./runc/v1.0.0-rc90/) | v0.1.0 |
| [runc-v1.0.0-rc10](./runc/v1.0.0-rc10/) | v0.2.0 |
| [runc-v1.0.0-rc9](./runc/v1.0.0-rc9/) | v0.1.0 | | ubuntu20.04 |
| [runc-v1.0.0-rc8](./runc/v1.0.0-rc8/) | v0.1.0 | | ubuntu20.04 |
| [runc-v1.0.0-rc7](./runc/v1.0.0-rc7/) | v0.1.0 | | ubuntu20.04, Bug: [#2043](https://github.com/opencontainers/runc/pull/2043) |
| [runc-v1.0.0-rc6](./runc/v1.0.0-rc6/) | v0.1.0 | | ubuntu20.04 |
| [runc-v1.0.0-rc5](./runc/v1.0.0-rc5/) | v0.1.0 | | ubuntu20.04 |
| [runc-v1.0.0-rc4](./runc/v1.0.0-rc4/) | v0.1.0 | | ubuntu20.04 |
| [runc-v1.0.0-rc3](./runc/v1.0.0-rc3/) | v0.1.0 |
| [runc-v1.0.0-rc3-dbg](./runc/v1.0.0-rc3-dbg/) | v0.1.0 |
| [runc-v1.0.0-rc2](./runc/v1.0.0-rc2/) | v0.1.0 |
| [runc-v1.0.0-rc2-dbg](./runc/v1.0.0-rc2-dbg/) | v0.1.0 |
| [runc-v1.0.0-rc1](./runc/v1.0.0-rc1/) | v0.1.0 | | ubuntu16.04 |
| [runc-v0.1.1](./runc/v0.1.1/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.1.0](./runc/v0.1.0/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.9](./runc/v0.0.9/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.8](./runc/v0.0.8/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.7](./runc/v0.0.7/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.6](./runc/v0.0.6/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.5](./runc/v0.0.5/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.4](./runc/v0.0.4/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.3](./runc/v0.0.3/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.2.1](./runc/v0.0.2.1/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.2](./runc/v0.0.2/) | v0.2.0 | | ubuntu16.04 |
| [runc-v0.0.1](./runc/v0.0.1/) | v0.2.0 | | ubuntu16.04 |

### ubuntu

| tag | version | alias |
| --- | --- | --- |
| [ubuntu-24.04](./ubuntu/24.04/) | v0.3.0 |
| [ubuntu-22.04-dbg](./ubuntu/22.04-dbg/) | v0.2.0 |
| [ubuntu-22.04](./ubuntu/22.04/) | v0.2.0 |
| [ubuntu-20.04](./ubuntu/20.04/) | v0.2.0 |
| [ubuntu-18.04](./ubuntu/18.04/) | v0.2.0 |
| [ubuntu-16.04](./ubuntu/16.04/) | v0.2.0 |
| [ubuntu-14.04](./ubuntu/14.04/) | v0.2.0 |
| [ubuntu-12.04](./ubuntu/12.04/) | v0.2.0 |

### debian

| tag | version | alias |
| --- | --- | --- |
| [debian-12.0](./debian/12.0/) | v0.2.0 | |

### centos

| tag | version | alias |
| --- | --- | --- |
| [centos-9](./centos/9/) | v0.2.0 | |
| [centos-8](./centos/8/) | v0.2.0 | |

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
