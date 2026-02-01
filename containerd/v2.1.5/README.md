# containerd v2.1.5

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.1.5 -> ssst0n3/docker_archive:containerd-v2.1.5_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.1.5_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.1.5 -> ssst0n3/docker_archive:ctr_containerd-v2.1.5_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.1.5_v0.1.0

## usage

```shell
$ cd containerd/v2.1.5
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-2-1-5:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.5 fcd43222d6b07379a4be9786bda52438f0dd16a1
root@containerd-2-1-5:~# runc --version
runc version 1.3.3
commit: v1.3.3-0-gd842d771
spec: 1.2.1
go: go1.23.12
libseccomp: 2.5.6
root@containerd-2-1-5:~# ctr i pull docker.io/library/hello-world:latest
root@containerd-2-1-5:~# ctr run docker.io/library/hello-world:latest hello

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

## build

```shell
make all DIR=containerd/v2.1.5
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.1.5_v0.1.0
```
