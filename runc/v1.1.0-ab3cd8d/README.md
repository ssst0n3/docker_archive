# v1.1.0-ab3cd8d

[commit ab3cd8d](https://github.com/opencontainers/runc/commit/ab3cd8d73e61847e16fbc2fd1ce054301dc240d4)

* dqd
    * ssst0n3/docker_archive:runc-v1.1.0-ab3cd8d -> ssst0n3/docker_archive:runc-v1.1.0-ab3cd8d_v0.2.0
    * ssst0n3/docker_archive:runc-v1.1.0-ab3cd8d_v0.2.0
    * ssst0n3/docker_archive:runc-v1.1.0-ab3cd8d_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.1.0-ab3cd8d -> ssst0n3/docker_archive:ctr_runc-v1.1.0-ab3cd8d_v0.2.0
    * ssst0n3/docker_archive:ctr_runc-v1.1.0-ab3cd8d_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_runc-v1.1.0-ab3cd8d_v0.1.0

## usage

```shell
$ cd runc/v1.1.0-ab3cd8d
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# runc --version
runc version 1.1.0+dev
commit: ab3cd8d-dirty
spec: 1.1.0+dev
go: go1.20.14
libseccomp: 2.5.4
root@localhost:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="20.04.6 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.6 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

```shell
root@localhost:~# mkdir -p rootfs/bin/
root@localhost:~# cp /bin/busybox rootfs/bin/
root@localhost:~# ln -s /bin/busybox rootfs/bin/sh
root@localhost:~# runc spec
root@localhost:~# runc run container-1


BusyBox v1.30.1 (Ubuntu 1:1.30.1-4ubuntu6.5) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/v1.1.0-ab3cd8d
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.1.0-ab3cd8d_v0.2.0
```
