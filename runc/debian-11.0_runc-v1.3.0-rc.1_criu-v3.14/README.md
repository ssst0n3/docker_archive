# runc v1.3.0-rc.1 with criu v3.14

* dqd
    * ssst0n3/docker_archive:debian-11.0_runc-v1.3.0-rc.1_criu-v3.14 -> ssst0n3/docker_archive:debian-11.0_runc-v1.3.0-rc.1_criu-v3.14_v0.1.0
    * ssst0n3/docker_archive:debian-11.0_runc-v1.3.0-rc.1_criu-v3.14_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1_criu-v3.14 -> ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1_criu-v3.14_v0.1.0
    * ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1_criu-v3.14_v0.1.0

## usage

```shell
$ cd runc/debian-11.0_runc-v1.3.0-rc.1_criu-v3.14
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@debuerreotype:~# criu --version
Version: 3.14
root@debuerreotype:~# runc --version
runc version 1.3.0-rc.1
commit: v1.3.0-rc.1-0-ga00ce11e
spec: 1.2.1
go: go1.23.6
libseccomp: 2.5.6
root@debuerreotype:~# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@debuerreotype:~# uname -a
Linux debuerreotype 5.10.0-35-amd64 #1 SMP Debian 5.10.237-1 (2025-05-19) x86_64 GNU/Linux
```

```shell
root@debuerreotype:~# mkdir -p rootfs/bin
cp /bin/busybox rootfs/
ln -s /busybox rootfs/bin/sh
runc spec
cat <<< $(jq '.process.terminal = false' config.json) > config.json
cat <<< $(jq '.process.args = ["/bin/sh", "-c", "sleep 1000"]' config.json) > config.json
root@debuerreotype:~# runc run -d test < /dev/null &> /dev/null
root@debuerreotype:~# runc list
ID          PID         STATUS      BUNDLE      CREATED                          OWNER
test        506         running     /root       2025-06-23T14:51:50.017081633Z   root
root@debuerreotype:~# runc checkpoint test
ERRO[0000] criu lacks support for external pid namespace during checkpointing process (old criu version?)
```

## build

```shell
make all DIR=runc/debian-11.0_runc-v1.3.0-rc.1_criu-v3.14
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_debian-11.0_runc-v1.3.0-rc.1_criu-v3.14_v0.1.0
```
