# containerd v2.1.3

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.1.3 -> ssst0n3/docker_archive:containerd-v2.1.3_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.1.3_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.1.3 -> ssst0n3/docker_archive:ctr_containerd-v2.1.3_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.1.3_v0.1.0

## usage

```shell
$ cd containerd/v2.1.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-2-1-3:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.3 c787fb98911740dd3ff2d0e45ce88cdf01410486
root@containerd-2-1-3:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@containerd-2-1-3:~# ctr i pull docker.io/library/ubuntu:24.04
root@containerd-2-1-3:~# ctr run docker.io/library/ubuntu:24.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v2.1.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.1.3_v0.1.0
```
