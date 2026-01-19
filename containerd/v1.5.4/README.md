# containerd v1.5.4

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.5.4 -> ssst0n3/docker_archive:containerd-v1.5.4_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.5.4_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.5.4 -> ssst0n3/docker_archive:ctr_containerd-v1.5.4_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.5.4_v0.1.0

## usage

```shell
$ cd containerd/v1.5.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-5-4:~# containerd --version
containerd github.com/containerd/containerd v1.5.4 69107e47a62e1d690afa2b9b1d43f8ece3ff4483
root@containerd-1-5-4:~# runc --version
runc version 1.0.0
commit: v1.0.0-0-g84113eef6fc2
spec: 1.0.2-dev
go: go1.16.4
libseccomp: 2.5.1
root@containerd-1-5-4:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-5-4:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.5.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.5.4_v0.1.0
```
