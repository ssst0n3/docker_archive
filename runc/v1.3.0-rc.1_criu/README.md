# runc v1.3.0-rc.1 with criu

* dqd
    * ssst0n3/docker_archive:runc-v1.3.0-rc.1_criu -> ssst0n3/docker_archive:runc-v1.3.0-rc.1_criu_v0.1.0
    * ssst0n3/docker_archive:runc-v1.3.0-rc.1_criu_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.3.0-rc.1_criu -> ssst0n3/docker_archive:ctr_runc-v1.3.0-rc.1_criu_v0.1.0
    * ssst0n3/docker_archive:ctr_runc-v1.3.0-rc.1_criu_v0.1.0

## usage

```shell
$ cd runc/v1.3.0-rc.1_criu
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# criu --version
Version: 4.1
root@localhost:~# runc --version
runc version 1.3.0-rc.1
commit: v1.3.0-rc.1-0-ga00ce11e
spec: 1.2.1
go: go1.23.6
libseccomp: 2.5.6
root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
```

```shell
root@localhost:~# mkdir -p rootfs/bin
root@localhost:~# cp /usr/bin/busybox rootfs/
root@localhost:~# ln -s /busybox rootfs/bin/sh
root@localhost:~# runc spec
root@localhost:~# cat <<< $(jq '.process.terminal = false' config.json) > config.json
root@localhost:~# cat <<< $(jq '.process.args = ["/bin/sh", "-c", "sleep inf"]' config.json) > config.json
root@localhost:~# runc run -d test < /dev/null &> /dev/null
root@localhost:~# runc list
ID          PID         STATUS      BUNDLE      CREATED                          OWNER
test        444         running     /root       2025-06-17T08:47:55.999095104Z   root
root@localhost:~# runc checkpoint test
root@localhost:~# runc list
ID          PID         STATUS      BUNDLE      CREATED     OWNER
root@localhost:~# runc restore -d test
root@localhost:~# runc list
ID          PID         STATUS      BUNDLE      CREATED                          OWNER
test        531         running     /root       2025-06-17T08:48:20.993013066Z   root
```

## build

```shell
make all DIR=runc/v1.3.0-rc.1_criu
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.3.0-rc.1_criu_v0.1.0
```
