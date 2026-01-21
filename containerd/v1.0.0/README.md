# containerd v1.0.0

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.0.0 -> ssst0n3/docker_archive:containerd-v1.0.0_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.0.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.0.0 -> ssst0n3/docker_archive:ctr_containerd-v1.0.0_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.0.0_v0.1.0

## usage

```shell
$ cd containerd/v1.0.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-0-0:~# containerd --version
containerd github.com/containerd/containerd v1.0.0 89623f28b87a6004d4b785663257362d1658a729
root@containerd-1-0-0:~# runc --version
runc version 1.0.0-rc4
commit: -dirty
spec: 1.0.0
root@containerd-1-0-0:~# ctr image pull docker.io/library/ubuntu:16.04
root@containerd-1-0-0:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.0.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.0.0_v0.1.0
```
