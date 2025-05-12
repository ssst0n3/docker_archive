# runc v1.0.0-rc7

* dqd
    * ssst0n3/docker_archive:runc-v1.0.0-rc7 -> ssst0n3/docker_archive:runc-v1.0.0-rc7_v0.2.0
    * ssst0n3/docker_archive:runc-v1.0.0-rc7_v0.2.0
    * ssst0n3/docker_archive:runc-v1.0.0-rc7_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc7 -> ssst0n3/docker_archive:ctr_runc-v1.0.0-rc7_v0.2.0
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc7_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc7_v0.1.0

## usage

```shell
$ cd runc/v1.0.0-rc7
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# runc --version
runc version 1.0.0-rc7
spec: 1.0.1-dev
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
container_linux.go:345: starting container process caused "process_linux.go:430: container init caused \"write /proc/self/attr/keycreate: invalid argument\""
```

## build

```shell
make all DIR=runc/v1.0.0-rc7
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.0.0-rc7_v0.2.0
```
