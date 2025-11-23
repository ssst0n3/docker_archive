# containerd v1.6.7

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.6.7 -> ssst0n3/docker_archive:containerd-v1.6.7_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.6.7_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.6.7 -> ssst0n3/docker_archive:ctr_containerd-v1.6.7_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.6.7_v0.1.0

## usage

```shell
$ cd containerd/v1.6.7
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@containerd-1-6-7:~# containerd --version
containerd github.com/containerd/containerd v1.6.7 0197261a30bf81f1ee8e6a4dd2dea0ef95d67ccb
root@containerd-1-6-7:~# runc --version
runc version 1.1.3
commit: v1.1.3-0-g6724737f
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@containerd-1-6-7:~# ctr i pull docker.io/library/busybox:latest
docker.io/library/busybox:latest:                                                 resolved       |++++++++++++++++++++++++++++++++++++++| 
index-sha256:e3652a00a2fabd16ce889f0aa32c38eec347b997e73bd09e69c962ec7f8732ee:    done           |++++++++++++++++++++++++++++++++++++++| 
manifest-sha256:870e815c3a50dd0f6b40efddb319c72c32c3ee340b5a3e8945904232ccd12f44: done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:e59838ecfec5e79eb4371e9995ef86c8000fe1c67d7b9fa7b57e996d9ba772ff:    done           |++++++++++++++++++++++++++++++++++++++| 
config-sha256:08ef35a1c3f050afbbd64194ffd1b8d5878659f5491567f26d1c814513ae9649:   done           |++++++++++++++++++++++++++++++++++++++| 
elapsed: 10.7s                                                                    total:  1.0 Mi (96.6 KiB/s)                                      
unpacking linux/amd64 sha256:e3652a00a2fabd16ce889f0aa32c38eec347b997e73bd09e69c962ec7f8732ee...
done: 159.163976ms	
root@containerd-1-6-7:~# ctr run docker.io/library/busybox:latest ctr id
uid=0(root) gid=0(root) groups=10(wheel)
root@containerd-1-6-7:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
root@containerd-1-6-7:~# uname -a
Linux containerd-1-6-7 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=containerd/v1.6.7
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.6.7_v0.1.0
```
