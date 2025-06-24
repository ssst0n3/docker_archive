# runc v1.2.0 (centos stream9)

* dqd
    * ssst0n3/docker_archive:centos-stream9_runc-v1.2.0 -> ssst0n3/docker_archive:centos-stream9_runc-v1.2.0_v0.1.0
    * ssst0n3/docker_archive:centos-stream9_runc-v1.2.0_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.2.0 -> ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.2.0_v0.1.0
    * ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.2.0_v0.1.0

## usage

```shell
$ cd runc/centos-stream9_runc-v1.2.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
[root@localhost ~]# sestatus 
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Memory protection checking:     actual (secure)
Max kernel policy version:      33
[root@localhost ~]# runc --version
runc version 1.2.0
commit: v1.2.0-0-g0b9fa21b
spec: 1.2.0
go: go1.22.8
libseccomp: 2.5.5
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
Linux localhost.localdomain 5.14.0-592.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jun 6 09:58:38 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

```shell
[root@localhost ~]# runc spec
[root@localhost ~]# runc run test
/ # cat /proc/self/attr/current 
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023/ 
```

## build

```shell
make all DIR=runc/centos-stream9_runc-v1.2.0_selinux
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.2.0_selinux_v0.1.0
```
