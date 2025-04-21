# docker v28.1.1

* dqd:
  * ssst0n3/docker_archive:docker-v28.1.1 -> ssst0n3/docker_archive:docker-v28.1.1_v0.1.0
  * ssst0n3/docker_archive:docker-v28.1.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.1.1 -> ssst0n3/docker_archive:ctr_docker-v28.1.1_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v28.1.1_v0.1.0

## usage

```shell
$ cd docker/v28.1.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# docker version

root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 24.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.1 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
root@localhost:~# uname -a
Linux localhost.localdomain 6.8.0-58-generic #60-Ubuntu SMP PREEMPT_DYNAMIC Fri Mar 14 18:29:48 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=docker/v28.1.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.1.1_v0.1.0
```
