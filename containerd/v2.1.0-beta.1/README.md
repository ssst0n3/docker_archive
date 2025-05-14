# containerd v2.1.0-beta.1

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.1.0-beta.1 -> ssst0n3/docker_archive:containerd-v2.1.0-beta.1_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.1.0-beta.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.1.0-beta.1 -> ssst0n3/docker_archive:ctr_containerd-v2.1.0-beta.1_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.1.0-beta.1_v0.1.0

## usage

```shell
$ cd containerd/v2.1.0-beta.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.0-beta.1 afc840ba5fad76459857839dc657ab16b39b35b5
root@localhost:~# runc --version
runc version 1.2.6
commit: v1.2.6-0-ge89a2992
spec: 1.2.0
go: go1.23.7
libseccomp: 2.5.5
root@localhost:~# ctr i pull docker.io/library/ubuntu:24.04
root@localhost:~# ctr run docker.io/library/ubuntu:24.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v2.1.0-beta.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.1.0-beta.1_v0.1.0
```
