# containerd v1.2.0

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.2.0 -> ssst0n3/docker_archive:containerd-v1.2.0_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.2.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.2.0 -> ssst0n3/docker_archive:ctr_containerd-v1.2.0_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.2.0_v0.1.0

## usage

```shell
$ cd containerd/v1.2.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-2-0:~# containerd --version
containerd github.com/containerd/containerd v1.2.0 c4446665cb9c30056f4998ed953e6d4ff22c7c39
root@containerd-1-2-0:~# runc --version
runc version 1.0.0-rc5
spec: 1.0.0
root@containerd-1-2-0:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-2-0:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.2.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.2.0_v0.1.0
```
