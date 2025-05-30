# runc v1.1.9

* dqd
    * ssst0n3/docker_archive:runc-v1.1.9 -> ssst0n3/docker_archive:runc-v1.1.9_v0.2.0
    * ssst0n3/docker_archive:runc-v1.1.9_v0.2.0
    * ssst0n3/docker_archive:runc-v1.1.9_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.1.9 -> ssst0n3/docker_archive:ctr_runc-v1.1.9_v0.2.0
    * ssst0n3/docker_archive:ctr_runc-v1.1.9_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_runc-v1.1.9_v0.1.0

## usage

```shell
$ cd runc/v1.1.9
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# runc --version
runc version 1.1.9
commit: v1.1.9-0-gccaecfcb
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
```

```shell
root@localhost:~# mkdir -p rootfs/bin/
root@localhost:~# cp /bin/busybox rootfs/bin/
root@localhost:~# ln -s /bin/busybox rootfs/bin/sh
root@localhost:~# runc spec
root@localhost:~# runc run container-1


BusyBox v1.36.1 (Ubuntu 1:1.36.1-6ubuntu3.1) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/v1.1.9
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.1.9_v0.2.0
```
