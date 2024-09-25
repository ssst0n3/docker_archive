# runc v1.1.2

* dqd
    * ssst0n3/docker_archive:runc-v1.1.2 (-> ssst0n3/docker_archive:runc-v1.1.2_v0.1.0)
    * ssst0n3/docker_archive:runc-v1.1.2_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.1.2 (-> ssst0n3/docker_archive:ctr_runc-v1.1.2_v0.1.0)
    * ssst0n3/docker_archive:ctr_runc-v1.1.2_v0.1.0

## usage

```shell
cd runc/v1.1.2
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.4 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.4 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

root@localhost:~# runc --version
runc version 1.1.2
commit: v1.1.2-0-ga916309f
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.3
```

```shell
root@localhost:~# mkdir -p rootfs/bin/
root@localhost:~# cp /bin/busybox rootfs/bin/
root@localhost:~# ln -s /bin/busybox rootfs/bin/sh
root@localhost:~# runc spec
root@localhost:~# runc run container-1


BusyBox v1.30.1 (Ubuntu 1:1.30.1-7ubuntu3.1) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/v1.1.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.1.2_v0.1.0
```