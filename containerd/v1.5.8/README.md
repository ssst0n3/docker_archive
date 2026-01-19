# containerd v1.5.8

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.5.8 -> ssst0n3/docker_archive:containerd-v1.5.8_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.5.8_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.5.8 -> ssst0n3/docker_archive:ctr_containerd-v1.5.8_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.5.8_v0.1.0

## usage

```shell
$ cd containerd/v1.5.8
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-5-8:~# containerd --version
containerd github.com/containerd/containerd v1.5.8 1e5ef943eb76627a6d3b6de8cd1ef6537f393a71
root@containerd-1-5-8:~# runc --version
runc version 1.0.2
commit: v1.0.2-0-g52b36a2dd837
spec: 1.0.2-dev
go: go1.16.7
libseccomp: 2.5.1
root@containerd-1-5-8:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-5-8:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.5.8
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.5.8_v0.1.0
```
