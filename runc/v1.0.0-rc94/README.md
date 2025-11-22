# runc v1.0.0-rc94

* dqd
    * ssst0n3/docker_archive:runc-v1.0.0-rc94 -> ssst0n3/docker_archive:runc-v1.0.0-rc94_v0.3.0
    * ssst0n3/docker_archive:runc-v1.0.0-rc94_v0.3.0
    * ssst0n3/docker_archive:runc-v1.0.0-rc94_v0.2.0
    * ssst0n3/docker_archive:runc-v1.0.0-rc94_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc94 -> ssst0n3/docker_archive:ctr_runc-v1.0.0-rc94_v0.3.0
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc94_v0.3.0: use ubuntu 20.04 as the base image
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc94_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc94_v0.1.0

## usage

```shell
$ cd runc/v1.0.0-rc94
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@runc-1-0-0-rc94:~# runc --version
runc version 1.0.0-rc94
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
root@runc-1-0-0-rc94:~# cat /etc/os-release
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
root@runc-1-0-0-rc94:~# uname -a
Linux runc-1-0-0-rc94 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

```shell
root@runc-1-0-0-rc94:~# mkdir -p rootfs/bin/
root@runc-1-0-0-rc94:~# cp /bin/busybox rootfs/bin/
root@runc-1-0-0-rc94:~# ln -s /bin/busybox rootfs/bin/sh
root@runc-1-0-0-rc94:~# runc spec
root@runc-1-0-0-rc94:~# runc run container-1


BusyBox v1.30.1 (Ubuntu 1:1.30.1-4ubuntu6.5) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/v1.0.0-rc94
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.0.0-rc94_v0.3.0
```
