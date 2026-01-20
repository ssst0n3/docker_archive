# containerd v1.3.0

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.3.0 -> ssst0n3/docker_archive:containerd-v1.3.0_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.3.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.3.0 -> ssst0n3/docker_archive:ctr_containerd-v1.3.0_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.3.0_v0.1.0

## usage

```shell
$ cd containerd/v1.3.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-3-0:~# containerd --version
containerd github.com/containerd/containerd v1.3.0 36cf5b690dcc00ff0f34ff7799209050c3d0c59a
root@containerd-1-3-0:~# runc --version
runc version 1.0.0-rc8
spec: 1.0.1-dev
root@containerd-1-3-0:~# ctr i pull docker.io/library/ubuntu:16.04
root@containerd-1-3-0:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.3.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.3.0_v0.1.0
```
