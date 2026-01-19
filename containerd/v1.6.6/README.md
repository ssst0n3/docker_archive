# containerd v1.6.6

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.6.6 -> ssst0n3/docker_archive:containerd-v1.6.6_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.6.6_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.6.6 -> ssst0n3/docker_archive:ctr_containerd-v1.6.6_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.6.6_v0.1.0

## usage

```shell
$ cd containerd/v1.6.6
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-6-6:~# containerd --version
containerd github.com/containerd/containerd v1.6.6 10c12954828e7c7c9b6e0ea9b0c02b01407d3ae1
root@containerd-1-6-6:~# runc --version
runc version 1.1.2
commit: v1.1.2-0-ga916309f
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.3
root@containerd-1-6-6:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-6-6:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.6.6
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.6.6_v0.1.0
```
