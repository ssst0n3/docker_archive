# containerd v1.5.9

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.5.9 -> ssst0n3/docker_archive:containerd-v1.5.9_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.5.9_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.5.9 -> ssst0n3/docker_archive:ctr_containerd-v1.5.9_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.5.9_v0.1.0

## usage

```shell
$ cd containerd/v1.5.9
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-5-9:~# containerd --version
containerd github.com/containerd/containerd v1.5.9 1407cab509ff0d96baa4f0eb6ff9980270e6e620
root@containerd-1-5-9:~# runc --version
runc version 1.0.3
commit: v1.0.3-0-gf46b6ba2c931
spec: 1.0.2-dev
go: go1.17.3
libseccomp: 2.5.1
root@containerd-1-5-9:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-5-9:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.5.9
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.5.9_v0.1.0
```
