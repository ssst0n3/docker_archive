# containerd v1.7.16

* dqd: 
    * ssst0n3/docker_archive:ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16 -> ssst0n3/docker_archive:ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16_v0.1.0
    * ssst0n3/docker_archive:ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16 -> ssst0n3/docker_archive:ctr_ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16_v0.1.0
    * ssst0n3/docker_archive:ctr_ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16_v0.1.0

## usage

```shell
cd containerd/v1.7.16
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@localhost:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
root@localhost:~# containerd --version
containerd github.com/containerd/containerd v1.7.16 83031836b2cf55637d7abf847b17134c51b38e53
root@localhost:~# ctr i pull docker.io/library/ubuntu:16.04
root@localhost:~# ctr run docker.io/library/ubuntu:16.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v1.7.16
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-22.04_runc-v1.1.12_containerd-v1.7.16_v0.1.0
```