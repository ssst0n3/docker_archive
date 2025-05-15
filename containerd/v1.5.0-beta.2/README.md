# containerd v1.5.0-beta.2

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.5.0-beta.2 -> ssst0n3/docker_archive:containerd-v1.5.0-beta.2_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.5.0-beta.2_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.5.0-beta.2 -> ssst0n3/docker_archive:ctr_containerd-v1.5.0-beta.2_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.5.0-beta.2_v0.1.0

## usage

```shell
$ cd containerd/v1.5.0-beta.2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd github.com/containerd/containerd v1.5.0-beta.2 07a3ce3d7f884f278f0d48b2d024b8ecf4e6f6bd
root@localhost:~# runc --version
runc version 1.0.0-rc93
spec: 1.0.2-dev
go: go1.14.14
libseccomp: 2.5.1
root@localhost:~# ctr i pull docker.io/library/ubuntu:16.04
root@localhost:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.5.0-beta.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.5.0-beta.2_v0.1.0
```
