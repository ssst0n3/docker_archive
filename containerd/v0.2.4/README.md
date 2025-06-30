# containerd v0.2.4

* dqd: 
    * ssst0n3/docker_archive:containerd-v0.2.4 -> ssst0n3/docker_archive:containerd-v0.2.4_v0.1.0
    * ssst0n3/docker_archive:containerd-v0.2.4_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v0.2.4 -> ssst0n3/docker_archive:ctr_containerd-v0.2.4_v0.1.0
    * ssst0n3/docker_archive:ctr_containerd-v0.2.4_v0.1.0

## usage

```shell
$ cd containerd/v0.2.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# containerd --version
containerd version 0.2.4 commit: 71861281661331fbc81936be81f05d8db71fc1ca
root@localhost:~# runc --version
runc version 1.0.0-rc1
commit: 04f275d4601ca7e5ff9460cec7f65e8dd15443ec
spec: 1.0.0-rc1
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
```

## build

```shell
make all DIR=containerd/v0.2.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v0.2.4_v0.1.0
```
