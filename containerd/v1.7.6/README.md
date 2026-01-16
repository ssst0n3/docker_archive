# containerd v1.7.6

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.7.6 -> ssst0n3/docker_archive:containerd-v1.7.6_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.7.6_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.7.6 -> ssst0n3/docker_archive:ctr_containerd-v1.7.6_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.7.6_v0.1.0

## usage

```shell
$ cd containerd/v1.7.6
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-7-6:~# containerd --version
containerd github.com/containerd/containerd v1.7.6 091922f03c2762540fd057fba91260237ff86acb
root@containerd-1-7-6:~# runc --version
runc version 1.1.9
commit: v1.1.9-0-gccaecfcb
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@containerd-1-7-6:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-7-6:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.7.6
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.7.6_v0.1.0
```
