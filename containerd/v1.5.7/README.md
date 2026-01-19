# containerd v1.5.7

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.5.7 -> ssst0n3/docker_archive:containerd-v1.5.7_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.5.7_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.5.7 -> ssst0n3/docker_archive:ctr_containerd-v1.5.7_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.5.7_v0.1.0

## usage

```shell
$ cd containerd/v1.5.7
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-5-7:~# containerd --version
containerd github.com/containerd/containerd v1.5.7 8686ededfc90076914c5238eb96c883ea093a8ba
root@containerd-1-5-7:~# runc --version
runc version 1.0.2
commit: v1.0.2-0-g52b36a2dd837
spec: 1.0.2-dev
go: go1.16.7
libseccomp: 2.5.1
root@containerd-1-5-7:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-5-7:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.5.7
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.5.7_v0.1.0
```
