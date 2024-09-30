# runc-issue-4047_commit-ab3cd8d

* issue: #4047
* PR: #4102
* [commit ab3cd8d](https://github.com/opencontainers/runc/commit/ab3cd8d73e61847e16fbc2fd1ce054301dc240d4)

* dqd
    * ssst0n3/docker_archive:runc-issue-4047_commit-ab3cd8d (-> ssst0n3/docker_archive:runc-issue-4047_commit-ab3cd8d_v0.1.0)
    * ssst0n3/docker_archive:runc-issue-4047_commit-ab3cd8d_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-issue-4047_commit-ab3cd8d (-> ssst0n3/docker_archive:ctr_runc-issue-4047_commit-ab3cd8d_v0.1.0)
    * ssst0n3/docker_archive:ctr_runc-issue-4047_commit-ab3cd8d_v0.1.0

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
root@localhost:~# 
```

There's no error reporting, and cgroups files not exits

```shell
root@localhost:~# ls -lah /sys/fs/cgroup/unified/container-1
ls: cannot access '/sys/fs/cgroup/unified/container-1': No such file or directory
```

## usage

```shell
cd issue/runc-issue-4047_commit-ab3cd8d
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
commit: ab3cd8d-dirty
spec: 1.1.0+dev
go: go1.20.14
libseccomp: 2.5.4
```

## build

```shell
make all DIR=issue/runc-issue-4047_commit-ab3cd8d
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-issue-4047_commit-ab3cd8d_v0.1.0
```