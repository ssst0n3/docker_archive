# containerd v1.6.12

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.6.12 -> ssst0n3/docker_archive:containerd-v1.6.12_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.6.12_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.6.12 -> ssst0n3/docker_archive:ctr_containerd-v1.6.12_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.6.12_v0.1.0

## usage

```shell
$ cd containerd/v1.6.12
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-6-12:~# containerd --version
containerd github.com/containerd/containerd v1.6.12 a05d175400b1145e5e6a735a6710579d181e7fb0
root@containerd-1-6-12:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@containerd-1-6-12:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-6-12:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.6.12
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.6.12_v0.1.0
```
