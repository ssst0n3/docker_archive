# containerd v1.3.8

* dqd: 
    * ssst0n3/docker_archive:containerd-v1.3.8 -> ssst0n3/docker_archive:containerd-v1.3.8_v0.1.0
    * ssst0n3/docker_archive:containerd-v1.3.8_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v1.3.8 -> ssst0n3/docker_archive:ctr_containerd-v1.3.8_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v1.3.8_v0.1.0

## usage

```shell
$ cd containerd/v1.3.8
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd github.com/containerd/containerd v1.3.8 7fb6e171309113ddcb8ea9599e34321550469250
root@localhost:~# runc --version
runc version 1.0.0-rc10
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
$ ./ssh
root@localhost:~# ctr i pull docker.io/library/busybox:latest
root@localhost:~# ctr run docker.io/library/busybox:latest ctr id
uid=0(root) gid=0(root) groups=10(wheel)
```

## build

```shell
make all DIR=containerd/v1.3.8
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v1.3.8_v0.1.0
```