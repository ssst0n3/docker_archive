# runc v1.1.8

* dqd
    * ssst0n3/docker_archive:runc-v1.1.8 (-> ssst0n3/docker_archive:runc-v1.1.8_v0.1.0)
    * ssst0n3/docker_archive:runc-v1.1.8_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.1.8 (-> ssst0n3/docker_archive:ctr_runc-v1.1.8_v0.1.0)
    * ssst0n3/docker_archive:ctr_runc-v1.1.8_v0.1.0

## usage

```shell
cd runc/v1.1.8
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 11800 root@127.0.0.1
```

```shell
root@localhost:~# runc --version
runc version 1.1.8
commit: v1.1.8-0-g82f18fe0
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
```

```shell
root@localhost:~# mkdir -p rootfs/bin/
root@localhost:~# cp /bin/busybox rootfs/bin/
root@localhost:~# ln -s /bin/busybox rootfs/bin/sh
root@localhost:~# runc spec
root@localhost:~# runc run container-1


BusyBox v1.30.1 (Ubuntu 1:1.30.1-7ubuntu3.1) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/v1.1.8
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.1.8_v0.1.0
```