# containerd v1.7.3

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.7.3 -> ssst0n3/docker_archive:containerd-v1.7.3_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.7.3_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.7.3 -> ssst0n3/docker_archive:ctr_containerd-v1.7.3_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.7.3_v0.1.0

## usage

```shell
$ cd containerd/v1.7.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-7-3:~# containerd --version
containerd github.com/containerd/containerd v1.7.3 7880925980b188f4c97b462f709d0db8e8962aff
root@containerd-1-7-3:~# runc --version
runc version 1.1.8
commit: v1.1.8-0-g82f18fe0
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@containerd-1-7-3:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-7-3:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.7.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.7.3_v0.1.0
```
