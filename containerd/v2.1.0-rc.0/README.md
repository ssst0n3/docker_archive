# containerd v2.1.0-rc.0

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.1.0-rc.0 -> ssst0n3/docker_archive:containerd-v2.1.0-rc.0_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.1.0-rc.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.0 -> ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.0_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.0_v0.1.0

## usage

```shell
$ cd containerd/v2.1.0-rc.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
root@localhost:~# runc --version
root@localhost:~# ctr i pull docker.io/library/ubuntu:24.04
root@localhost:~# ctr run docker.io/library/ubuntu:24.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v2.1.0-rc.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.1.0-rc.0_v0.1.0
```
