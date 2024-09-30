# runc-pr-3825_commit-7d09ba1

* issue: #4047
* PR: #4102
* [commit 7d09ba1](https://github.com/opencontainers/runc/pull/3825/commits/7d09ba10cc873f3332dd3de5304fbcd6814d72eb)

* dqd
    * ssst0n3/docker_archive:runc-pr-3825_commit-7d09ba1 (-> ssst0n3/docker_archive:runc-pr-3825_commit-7d09ba1_v0.1.0)
    * ssst0n3/docker_archive:runc-pr-3825_commit-7d09ba1_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-pr-3825_commit-7d09ba1 (-> ssst0n3/docker_archive:ctr_runc-pr-3825_commit-7d09ba1_v0.1.0)
    * ssst0n3/docker_archive:ctr_runc-pr-3825_commit-7d09ba1_v0.1.0

## reproduce

```shell
root@localhost:~# ./poc.sh 
prepare env
please run 'runc run container-1' @ terminal1
run 'runc exec container-1 sleep 9999' @ terminal2
```

@terminal1

```shell
root@localhost:~# runc run container-1

```

@terminal2

```shell
root@localhost:~# runc exec container-1 sleep 9999
root@localhost:~#
```

@terminal1

```shell
root@localhost:~# runc run container-1
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/devices/user.slice/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/pids/user.slice/user-0.slice/session-1.scope/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/net_cls,net_prio/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/freezer/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/perf_event/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/cpuset/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/memory/user.slice/user-0.slice/session-1.scope/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/cpu,cpuacct/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/cpu,cpuacct/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/hugetlb/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/unified/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/blkio/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/net_cls,net_prio/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/rdma/container-1: device or resource busy"
WARN[0020] Failed to remove cgroup (will retry)          error="rmdir /sys/fs/cgroup/systemd/user.slice/user-0.slice/session-1.scope/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/perf_event/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/cpu,cpuacct/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/hugetlb/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/unified/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/cpuset/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/memory/user.slice/user-0.slice/session-1.scope/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/cpu,cpuacct/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/systemd/user.slice/user-0.slice/session-1.scope/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/blkio/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/net_cls,net_prio/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/rdma/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/freezer/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/devices/user.slice/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/pids/user.slice/user-0.slice/session-1.scope/container-1: device or resource busy"
ERRO[0020] Failed to remove cgroup                       error="rmdir /sys/fs/cgroup/net_cls,net_prio/container-1: device or resource busy"
ERRO[0020] Failed to remove paths: map[:/sys/fs/cgroup/unified/container-1 blkio:/sys/fs/cgroup/blkio/container-1 cpu:/sys/fs/cgroup/cpu,cpuacct/container-1 cpuacct:/sys/fs/cgroup/cpu,cpuacct/container-1 cpuset:/sys/fs/cgroup/cpuset/container-1 devices:/sys/fs/cgroup/devices/user.slice/container-1 freezer:/sys/fs/cgroup/freezer/container-1 hugetlb:/sys/fs/cgroup/hugetlb/container-1 memory:/sys/fs/cgroup/memory/user.slice/user-0.slice/session-1.scope/container-1 name=systemd:/sys/fs/cgroup/systemd/user.slice/user-0.slice/session-1.scope/container-1 net_cls:/sys/fs/cgroup/net_cls,net_prio/container-1 net_prio:/sys/fs/cgroup/net_cls,net_prio/container-1 perf_event:/sys/fs/cgroup/perf_event/container-1 pids:/sys/fs/cgroup/pids/user.slice/user-0.slice/session-1.scope/container-1 rdma:/sys/fs/cgroup/rdma/container-1] 
root@localhost:~#
```

There's an error warning, and cgroups files exits

```shell
root@localhost:~# ls -lah /sys/fs/cgroup/unified/container-1
total 0
drwxr-xr-x 2 root root 0 Sep 30 03:52 .
dr-xr-xr-x 6 root root 0 Sep 30 03:52 ..
-r--r--r-- 1 root root 0 Sep 30 03:54 cgroup.controllers
-r--r--r-- 1 root root 0 Sep 30 03:54 cgroup.events
-rw-r--r-- 1 root root 0 Sep 30 03:54 cgroup.freeze
-rw-r--r-- 1 root root 0 Sep 30 03:54 cgroup.max.depth
-rw-r--r-- 1 root root 0 Sep 30 03:54 cgroup.max.descendants
-rw-r--r-- 1 root root 0 Sep 30 03:52 cgroup.procs
-r--r--r-- 1 root root 0 Sep 30 03:54 cgroup.stat
-rw-r--r-- 1 root root 0 Sep 30 03:54 cgroup.subtree_control
-rw-r--r-- 1 root root 0 Sep 30 03:54 cgroup.threads
-rw-r--r-- 1 root root 0 Sep 30 03:54 cgroup.type
-rw-r--r-- 1 root root 0 Sep 30 03:54 cpu.pressure
-r--r--r-- 1 root root 0 Sep 30 03:54 cpu.stat
-rw-r--r-- 1 root root 0 Sep 30 03:54 io.pressure
-rw-r--r-- 1 root root 0 Sep 30 03:54 memory.pressure
```

## usage

```shell
cd issue/runc-pr-3825_commit-7d09ba1
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
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

root@localhost:~# runc --version
runc version 1.1.0+dev
commit: 7d09ba1-dirty
spec: 1.1.0-rc.2
go: go1.20.14
libseccomp: 2.5.4
```

## build

```shell
make all DIR=issue/runc-pr-3825_commit-7d09ba1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-pr-3825_commit-7d09ba1_v0.1.0
```