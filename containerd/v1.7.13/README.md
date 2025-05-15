# containerd v1.7.13

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.7.13 -> ssst0n3/docker_archive:containerd-v1.7.13_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.7.13_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.7.13 -> ssst0n3/docker_archive:ctr_containerd-v1.7.13_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.7.13_v0.1.0

## usage

```shell
$ cd containerd/v1.7.13
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd github.com/containerd/containerd v1.7.13 7c3aca7a610df76212171d200ca3811ff6096eb8
root@localhost:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
root@localhost:~# ctr i pull docker.io/library/ubuntu:16.04
root@localhost:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.7.13
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.7.13_v0.1.0
```
