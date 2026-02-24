# containerd v2.2.1

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.2.1 -> ssst0n3/docker_archive:containerd-v2.2.1_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.2.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.2.1 -> ssst0n3/docker_archive:ctr_containerd-v2.2.1_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.2.1_v0.1.0

## usage

### start up

```shell
$ cd containerd/v2.2.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### run a container

```shell
root@containerd-2-2-1:~# ctr i pull docker.io/library/hello-world:latest
root@containerd-2-2-1:~# ctr run docker.io/library/hello-world:latest hello

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

### versions

```shell
$ ./ssh
root@containerd-2-2-1:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.2.1 dea7da592f5d1d2b7755e3a161be07f43fad8f75
root@containerd-2-2-1:~# runc --version
runc version 1.3.4
commit: v1.3.4-0-gd6d73eb8
spec: 1.2.1
go: go1.24.10
libseccomp: 2.5.6
```

## build

```shell
make all DIR=containerd/v2.2.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.2.1_v0.1.0
```

