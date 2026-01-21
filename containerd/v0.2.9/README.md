# containerd v0.2.9

* dqd: 
    * ssst0n3/docker_archive:containerd-v0.2.9 -> ssst0n3/docker_archive:containerd-v0.2.9_v0.1.0
    * ssst0n3/docker_archive:containerd-v0.2.9_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v0.2.9 -> ssst0n3/docker_archive:ctr_containerd-v0.2.9_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v0.2.9_v0.1.0

## usage

```shell
$ cd containerd/v0.2.9
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-0-2-9:~# containerd --version
containerd version 0.2.3 commit: cfb82a876ecc11b5ca0977d1733adbe58599088a
root@containerd-0-2-9:~# runc --version
runc version 1.0.0-rc3
commit: -dirty
spec: 1.0.0-rc5
```

## build

```shell
make all DIR=containerd/v0.2.9
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v0.2.9_v0.1.0
```
