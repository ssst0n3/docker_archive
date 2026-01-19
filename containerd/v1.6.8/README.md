# containerd v1.6.8

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.6.8 -> ssst0n3/docker_archive:containerd-v1.6.8_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.6.8_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.6.8 -> ssst0n3/docker_archive:ctr_containerd-v1.6.8_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.6.8_v0.1.0

## usage

```shell
$ cd containerd/v1.6.8
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-6-8:~# containerd --version
containerd github.com/containerd/containerd v1.6.8 9cd3357b7fd7218e4aec3eae239db1f68a5a6ec6
root@containerd-1-6-8:~# runc --version
runc version 1.1.3
commit: v1.1.3-0-g6724737f
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@containerd-1-6-8:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-6-8:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.6.8
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.6.8_v0.1.0
```
