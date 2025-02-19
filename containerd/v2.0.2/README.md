# containerd v2.0.2

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.0.2 -> ssst0n3/docker_archive:containerd-v2.0.2_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.0.2_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.0.2 -> ssst0n3/docker_archive:ctr_containerd-v2.0.2_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v2.0.2_v0.1.0

## usage

```shell
cd containerd/v2.0.2
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@localhost:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.2 c507a0257ea6462fbd6f5ba4f5c74facb04021f4
root@localhost:~# ctr i pull docker.io/library/ubuntu:24.04
root@localhost:~# ctr run docker.io/library/ubuntu:24.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v2.0.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.0.2_v0.1.0
```