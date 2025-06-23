# runc v1.3.0-rc.1 (debian 11.0)

* dqd
    * ssst0n3/docker_archive:debian-11.0_runc-v1.3.0-rc.1 -> ssst0n3/docker_archive:debian-11.0_runc-v1.3.0-rc.1_v0.1.0
    * ssst0n3/docker_archive:debian-11.0_runc-v1.3.0-rc.1_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1 -> ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1_v0.1.0
    * ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1_v0.1.0

## usage

```shell
$ cd runc/debian-11.0_runc-v1.3.0-rc.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@debuerreotype:~# runc --version
runc version 1.3.0-rc.1
commit: v1.3.0-rc.1-0-ga00ce11e
spec: 1.2.1
go: go1.23.6
libseccomp: 2.5.6
root@debuerreotype:~# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@debuerreotype:~# uname -a
Linux debuerreotype 5.10.0-35-amd64 #1 SMP Debian 5.10.237-1 (2025-05-19) x86_64 GNU/Linux
```

```shell
root@debuerreotype:~# mkdir -p rootfs/bin/
cp /bin/busybox rootfs/bin/
ln -s /bin/busybox rootfs/bin/sh
runc spec
runc run container-1


BusyBox v1.30.1 (Debian 1:1.30.1-6+deb11u1) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/debian-11.0_runc-v1.3.0-rc.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1_v0.1.0
```
