# containerd v1.7.0

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.7.0 -> ssst0n3/docker_archive:containerd-v1.7.0_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.7.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.7.0 -> ssst0n3/docker_archive:ctr_containerd-v1.7.0_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.7.0_v0.1.0

## usage

```shell
$ cd containerd/v1.7.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-7-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.0 1fbd70374134b891f97ce19c70b6e50c7b9f4e0d
root@containerd-1-7-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@containerd-1-7-0:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-7-0:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.7.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.7.0_v0.1.0
```
