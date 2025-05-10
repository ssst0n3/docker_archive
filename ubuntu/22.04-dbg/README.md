# docker v22.04 dbg

* dqd: 
	* ssst0n3/docker_archive:ubuntu-22.04-dbg -> ssst0n3/docker_archive:ubuntu-22.04-dbg_v0.2.0
	* ssst0n3/docker_archive:ubuntu-22.04-dbg_v0.2.0
	* ssst0n3/docker_archive:ubuntu-22.04-dbg_v0.1.0
* ctr: 
	* ssst0n3/docker_archive:ctr_ubuntu-22.04-dbg -> ssst0n3/docker_archive:ctr_ubuntu-22.04-dbg_v0.2.0
	* ssst0n3/docker_archive:ctr_ubuntu-22.04-dbg_v0.2.0: bump base image to v0.2.0
	* ssst0n3/docker_archive:ctr_ubuntu-22.04-dbg_v0.1.0

## debug

### 1. gdb in docker (recommend)

```
$ docker compose up -d
$ docker exec -ti ubuntu-22-04-dbg-vm-1 bash
root@276954a1c0af:/# gdb /vmlinux
(gdb) target remote :1234
Remote debugging using :1234
0x000000000000fff0 in exception_stacks ()
(gdb) c
Continuing.
```

## env

KVM is not recommended for debugging kernel.

vm:

```shell
$ ./ssh
root@localhost:~# uname -a
Linux localhost.localdomain 5.15.0-139-generic #149-Ubuntu SMP Fri Apr 11 22:06:13 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

ctr:

```shell
$ docker exec -ti ubuntu-22-04-dbg-vm-1 bash
root@bbed7ea6e45e:/# dpkg -l |grep linux
ii  linux-image-5.15.0-139-generic                 5.15.0-139.149                          amd64        Signed kernel image generic
ii  linux-image-5.15.0-139-generic-dbgsym          5.15.0-139.149                          amd64        Signed kernel image generic
ii  linux-image-unsigned-5.15.0-139-generic-dbgsym 5.15.0-139.149                          amd64        Linux kernel debug image for version 5.15.0 on 64 bit x86 SMP
ii  linux-source-5.15.0                            5.15.0-139.149                          all          Linux kernel source for version 5.15.0 with Ubuntu patches
...
```

## build

```shell
make dbg DIR=ubuntu/22.04-dbg
```

for developers:

Dockerfile.dbg

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-22.04-dbg_v0.2.0
```

Dockerfile: as your need
