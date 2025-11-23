# runc v1.1.3

* dqd
    * ssst0n3/docker_archive:runc-v1.1.3 -> ssst0n3/docker_archive:runc-v1.1.3_v0.3.0
    * ssst0n3/docker_archive:runc-v1.1.3_v0.3.0
    * ssst0n3/docker_archive:runc-v1.1.3_v0.2.0
    * ssst0n3/docker_archive:runc-v1.1.3_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.1.3 -> ssst0n3/docker_archive:ctr_runc-v1.1.3_v0.3.0
    * ssst0n3/docker_archive:ctr_runc-v1.1.3_v0.3.0: use ubuntu 22.04 as the base image
    * ssst0n3/docker_archive:ctr_runc-v1.1.3_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_runc-v1.1.3_v0.1.0

## usage

```shell
$ cd runc/v1.1.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@runc-1-1-3:~# runc --version
runc version 1.1.3
commit: v1.1.3-0-g6724737f
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@runc-1-1-3:~# cat /etc/os-release
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
root@runc-1-1-3:~# uname -a
Linux runc-1-1-3 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

```shell
root@runc-1-1-3:~# mkdir -p rootfs/bin/
cp /bin/busybox rootfs/bin/
ln -s /bin/busybox rootfs/bin/sh
runc spec
runc run container-1


BusyBox v1.30.1 (Ubuntu 1:1.30.1-7ubuntu3.1) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/v1.1.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.1.3_v0.3.0
```
