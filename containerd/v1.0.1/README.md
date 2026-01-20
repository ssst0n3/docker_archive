# containerd v1.0.1

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.0.1 -> ssst0n3/docker_archive:containerd-v1.0.1_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.0.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.0.1 -> ssst0n3/docker_archive:ctr_containerd-v1.0.1_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.0.1_v0.1.0

## usage

```shell
$ cd containerd/v1.0.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-0-1:~# containerd --version
containerd github.com/containerd/containerd v1.0.1 9b55aab90508bd389d7654c4baf173a981477d55
root@containerd-1-0-1:~# runc --version
runc version 1.0.0-rc4
commit: -dirty
spec: 1.0.0
root@containerd-1-0-1:~# ctr image pull docker.io/library/ubuntu:16.04
root@containerd-1-0-1:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.0.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.0.1_v0.1.0
```
