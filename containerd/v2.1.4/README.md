# containerd v2.1.4

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.1.4 -> ssst0n3/docker_archive:containerd-v2.1.4_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.1.4_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.1.4 -> ssst0n3/docker_archive:ctr_containerd-v2.1.4_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.1.4_v0.1.0

## usage

```shell
$ cd containerd/v2.1.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.4 75cb2b7193e4e490e9fbdc236c0e811ccaba3376
root@localhost:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@localhost:~# ctr i pull docker.io/library/hello-world:latest
root@localhost:~# ctr run docker.io/library/hello-world:latest hello

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

## build

```shell
make all DIR=containerd/v2.1.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.1.4_v0.1.0
```
