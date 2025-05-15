# containerd v1.4.3

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.4.3 -> ssst0n3/docker_archive:containerd-v1.4.3_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.4.3_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.4.3 -> ssst0n3/docker_archive:ctr_containerd-v1.4.3_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.4.3_v0.1.0

## usage

```shell
$ cd containerd/v1.4.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd github.com/containerd/containerd v1.4.3 269548fa27e0089a8b8278fc4fc781d7f65a939b
root@localhost:~# runc --version
runc version 1.0.0-rc92
spec: 1.0.2-dev
root@localhost:~# ctr i pull docker.io/library/ubuntu:16.04
root@localhost:~# ctr run docker.io/library/ubuntu:16.04 ctr id
```

## build

```shell
make all DIR=containerd/v1.4.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.4.3_v0.1.0
```
