# docker-compose v2.40.0

* dqd:
  * ssst0n3/docker_archive:docker-compose-v2.40.0 -> ssst0n3/docker_archive:docker-compose-v2.40.0_v0.1.0
  * ssst0n3/docker_archive:docker-compose-v2.40.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-compose-v2.40.0 -> ssst0n3/docker_archive:ctr_docker-compose-v2.40.0_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-compose-v2.40.0_v0.1.0

## usage

```shell
$ cd docker-compose/v2.40.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@docker-compose-2-40-0:~# docker compose
Usage:  docker compose [OPTIONS] COMMAND
...
```

## env details

```shell
root@docker-compose-2-40-0:~# docker compose version
Docker Compose version v2.40.0
root@docker-compose-2-40-0:~# docker version
Client: Docker Engine - Community
 Version:           28.3.2
 API version:       1.51
 Go version:        go1.24.5
 Git commit:        578ccf6
 Built:             Wed Jul  9 16:13:45 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.3.2
  API version:      1.51 (minimum version 1.24)
  Go version:       go1.24.5
  Git commit:       e77ff99
  Built:            Wed Jul  9 16:13:45 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.27
  GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
 runc:
  Version:          1.2.5
  GitCommit:        v1.2.5-0-g59923ef
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
root@docker-compose-2-40-0:~# containerd --version
containerd containerd.io 1.7.27 05044ec0a9a75232cad458027ca83437aae3f4da
root@docker-compose-2-40-0:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef
spec: 1.2.0
go: go1.23.7
libseccomp: 2.5.5
root@docker-compose-2-40-0:~# cat /etc/os-release 
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
root@docker-compose-2-40-0:~# uname -a
Linux docker-compose-2-40-0 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=docker-compose/v2.40.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-compose-v2.40.0_v0.1.0
```

