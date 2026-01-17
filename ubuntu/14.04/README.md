# ubuntu 14.04

* dqd: 
    * ssst0n3/docker_archive:ubuntu-14.04 -> ssst0n3/docker_archive:ubuntu-14.04_v0.2.0
    * ssst0n3/docker_archive:ubuntu-14.04_v0.2.0
    * ssst0n3/docker_archive:ubuntu-14.04_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_ubuntu-14.04 -> ssst0n3/docker_archive:ctr_ubuntu-14.04_v0.2.0
    * ssst0n3/docker_archive:ctr_ubuntu-14.04_v0.2.0
    * ssst0n3/docker_archive:ctr_ubuntu-14.04_v0.1.0

## usage

```shell
$ cd ubuntu/14.04
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ssh dqd-ubuntu-14.04
root@localhost:~# uname -a
Linux localhost.localdomain 3.13.0-170-generic #220-Ubuntu SMP Thu May 9 12:40:49 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="14.04.6 LTS, Trusty Tahr"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 14.04.6 LTS"
VERSION_ID="14.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
```

## build

```shell
make all DIR=ubuntu/14.04
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-14.04_v0.2.0
```