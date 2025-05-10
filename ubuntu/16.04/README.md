# ubuntu 16.04

* dqd: 
    * ssst0n3/docker_archive:ubuntu-16.04 -> ssst0n3/docker_archive:ubuntu-16.04_v0.2.0
    * ssst0n3/docker_archive:ubuntu-16.04_v0.2.0
    * ssst0n3/docker_archive:ubuntu-16.04_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_ubuntu-16.04 -> ssst0n3/docker_archive:ctr_ubuntu-16.04_v0.2.0
    * ssst0n3/docker_archive:ctr_ubuntu-16.04_v0.2.0: install the built-in ssh key
    * ssst0n3/docker_archive:ctr_ubuntu-16.04_v0.1.0

## usage

```shell
$ cd ubuntu/16.04
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ssh ubuntu-16.04
root@localhost:~# uname -a
Linux localhost.localdomain 4.4.0-210-generic #242-Ubuntu SMP Fri Apr 16 09:57:56 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
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
make all DIR=ubuntu/16.04
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-16.04_v0.2.0
```
