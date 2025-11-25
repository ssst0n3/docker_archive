# containerd v1.7.15

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.7.15 -> ssst0n3/docker_archive:containerd-v1.7.15_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.7.15_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.7.15 -> ssst0n3/docker_archive:ctr_containerd-v1.7.15_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.7.15_v0.1.0

## usage

```shell
$ cd containerd/v1.7.15
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-7-15:~# containerd --version
containerd github.com/containerd/containerd v1.7.15 926c9586fe4a6236699318391cd44976a98e31f1
root@containerd-1-7-15:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
root@containerd-1-7-15:~# ctr i pull docker.io/library/busybox:latest
docker.io/library/busybox:latest:                                                 resolved       |++++++++++++++++++++++++++++++++++++++| 
index-sha256:e3652a00a2fabd16ce889f0aa32c38eec347b997e73bd09e69c962ec7f8732ee:    done           |++++++++++++++++++++++++++++++++++++++| 
manifest-sha256:870e815c3a50dd0f6b40efddb319c72c32c3ee340b5a3e8945904232ccd12f44: done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:e59838ecfec5e79eb4371e9995ef86c8000fe1c67d7b9fa7b57e996d9ba772ff:    done           |++++++++++++++++++++++++++++++++++++++| 
config-sha256:08ef35a1c3f050afbbd64194ffd1b8d5878659f5491567f26d1c814513ae9649:   done           |++++++++++++++++++++++++++++++++++++++| 
elapsed: 10.9s                                                                    total:  2.0 Mi (188.8 KiB/s)                                     
unpacking linux/amd64 sha256:e3652a00a2fabd16ce889f0aa32c38eec347b997e73bd09e69c962ec7f8732ee...
done: 175.912196ms	
root@containerd-1-7-15:~# ctr run docker.io/library/busybox:latest ctr id
uid=0(root) gid=0(root) groups=0(root),10(wheel)
```

## build

```shell
make all DIR=containerd/v1.7.15
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.7.15_v0.1.0
```
