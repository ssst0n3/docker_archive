# podman v5.5.1

* dqd:
  * ssst0n3/docker_archive:podman-v5.5.1 -> ssst0n3/docker_archive:podman-v5.5.1_v0.1.0
  * ssst0n3/docker_archive:podman-v5.5.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_podman-v5.5.1 -> ssst0n3/docker_archive:ctr_podman-v5.5.1_v0.1.0
  * ssst0n3/docker_archive:ctr_podman-v5.5.1_v0.1.0

## usage

```shell
$ cd podman/v5.5.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
[root@localhost ~]# podman run hello-world
Resolved "hello-world" as an alias (/etc/containers/registries.conf.d/000-shortnames.conf)
Trying to pull quay.io/podman/hello:latest...
Getting image source signatures
Copying blob 81df7ff16254 done   | 
Copying config 5dd467fce5 done   | 
Writing manifest to image destination
!... Hello Podman World ...!
...
```

```shell
$ ./ssh
[root@localhost ~]# podman version
Client:       Podman Engine
Version:      5.5.1
API Version:  5.5.1
Go Version:   go1.24.3 (Red Hat 1.24.3-3.el9)
Built:        Tue Jun 10 14:32:25 2025
OS/Arch:      linux/amd64
[root@localhost ~]# crun --version
crun version 1.22
commit: 4de19b63a85efd9ea8503452179c371181750130
rundir: /run/user/0/crun
spec: 1.0.0
+SYSTEMD +SELINUX +APPARMOR +CAP +SECCOMP +EBPF +CRIU +YAJL
[root@localhost ~]# cat /etc/os-release
NAME="CentOS Stream"
VERSION="9"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="9"
PLATFORM_ID="platform:el9"
PRETTY_NAME="CentOS Stream 9"
ANSI_COLOR="0;31"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:centos:centos:9"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://issues.redhat.com/"
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 9"
REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream"
[root@localhost ~]# uname -a
Linux localhost.localdomain 5.14.0-596.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jun 27 16:02:33 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=podman/v5.5.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_podman-v5.5.1_v0.1.0
```
