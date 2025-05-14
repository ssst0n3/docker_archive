# containerd v2.1.0-rc.1

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.1.0-rc.1 -> ssst0n3/docker_archive:containerd-v2.1.0-rc.1_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.1.0-rc.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.1 -> ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.1_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.1_v0.1.0

## usage

```shell
$ cd containerd/v2.1.0-rc.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.0-rc.1 5a3bbca1bb2783f73fead2fd127e91bb7032f36e
root@localhost:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@localhost:~# ctr i pull docker.io/library/ubuntu:24.04
root@localhost:~# ctr run docker.io/library/ubuntu:24.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v2.1.0-rc.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.1_v0.1.0
```
