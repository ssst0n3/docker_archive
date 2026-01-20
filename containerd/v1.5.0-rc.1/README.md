# containerd v1.5.0-rc.1

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.5.0-rc.1 -> ssst0n3/docker_archive:containerd-v1.5.0-rc.1_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.5.0-rc.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.5.0-rc.1 -> ssst0n3/docker_archive:ctr_containerd-v1.5.0-rc.1_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.5.0-rc.1_v0.1.0

## usage

```shell
$ cd containerd/v1.5.0-rc.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-5-0-rc-1:~# containerd --version
containerd github.com/containerd/containerd v1.5.0-rc.1 f968359ecb3b581e6b61d2c7072f2e4b5347d560
root@containerd-1-5-0-rc-1:~# runc --version
runc version 1.0.0-rc93
spec: 1.0.2-dev
go: go1.14.14
libseccomp: 2.5.1
root@containerd-1-5-0-rc-1:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-5-0-rc-1:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.5.0-rc.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.5.0-rc.1_v0.1.0
```
