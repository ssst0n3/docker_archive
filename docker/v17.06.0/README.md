# docker v17.06.0

* dqd:
  * ssst0n3/docker_archive:docker-v17.06.0 -> ssst0n3/docker_archive:docker-v17.06.0_v0.1.0
  * ssst0n3/docker_archive:docker-v17.06.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v17.06.0 -> ssst0n3/docker_archive:ctr_docker-v17.06.0_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v17.06.0_v0.1.0

## usage

```shell
$ cd docker/v17.06.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# docker version
Client:
 Version:      17.06.0-ce
 API version:  1.30
 Go version:   go1.8.3
 Git commit:   02c1d87
 Built:        Fri Jun 23 21:23:31 2017
 OS/Arch:      linux/amd64

Server:
 Version:      17.06.0-ce
 API version:  1.30 (minimum version 1.12)
 Go version:   go1.8.3
 Git commit:   02c1d87
 Built:        Fri Jun 23 21:19:04 2017
 OS/Arch:      linux/amd64
 Experimental: false
root@localhost:~# docker-containerd --version
containerd version 0.2.3 commit: cfb82a876ecc11b5ca0977d1733adbe58599088a
root@localhost:~# docker-runc --version
runc version 1.0.0-rc3
commit: 2d41c047c83e09a6d61d464906feb2a2f3c52aa4
spec: 1.0.0-rc5
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
root@localhost:~# uname -a
Linux localhost.localdomain 4.4.0-210-generic #242-Ubuntu SMP Fri Apr 16 09:57:56 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
```

```shell
$ ./ssh
root@localhost:~# docker run -ti ubuntu:16.04 id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=docker/v17.06.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v17.06.0_v0.1.0
```
