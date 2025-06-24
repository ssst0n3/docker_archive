# runc v1.3.0-rc.1 with selinux (centos stream9)

* dqd
    * ssst0n3/docker_archive:centos-stream9_runc-v1.3.0-rc.1_selinux -> ssst0n3/docker_archive:centos-stream9_runc-v1.3.0-rc.1_selinux_v0.1.0
    * ssst0n3/docker_archive:centos-stream9_runc-v1.3.0-rc.1_selinux_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.3.0-rc.1_selinux -> ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.3.0-rc.1_selinux_v0.1.0
    * ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.3.0-rc.1_selinux_v0.1.0

## usage

```shell
$ cd runc/centos-stream9_runc-v1.3.0-rc.1_selinux
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
runc version 1.3.0-rc.1
commit: v1.3.0-rc.1-0-ga00ce11e
spec: 1.2.1
go: go1.23.6
libseccomp: 2.5.6
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
make all DIR=runc/centos-stream9_runc-v1.3.0-rc.1_selinux
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_centos-stream9_runc-v1.3.0-rc.1_selinux_v0.1.0
```
