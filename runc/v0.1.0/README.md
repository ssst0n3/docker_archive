# runc v0.1.0

* dqd
    * ssst0n3/docker_archive:runc-v0.1.0 (-> ssst0n3/docker_archive:runc-v0.1.0_v0.1.0)
    * ssst0n3/docker_archive:runc-v0.1.0_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v0.1.0 (-> ssst0n3/docker_archive:ctr_runc-v0.1.0_v0.1.0)
    * ssst0n3/docker_archive:ctr_runc-v0.1.0_v0.1.0

## usage

```shell
cd runc/v0.1.0
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@localhost:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="16.04.7 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.7 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
root@localhost:~# runc --version
runc version 0.1.0
commit: 8e129e097220b2591edd59957c4ff08e064e14b9
spec: 0.5.0
```

```shell
root@localhost:~# mkdir -p rootfs/bin/
root@localhost:~# cp /bin/busybox rootfs/bin/
root@localhost:~# ln -s /bin/busybox rootfs/bin/sh
root@localhost:~# runc spec
root@localhost:~# runc start container-1


BusyBox v1.22.1 (Ubuntu 1:1.22.0-15ubuntu1.4) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ #
```

## build

```shell
make all DIR=runc/v0.1.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v0.1.0_v0.1.0
```