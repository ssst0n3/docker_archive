# docker v28.0.4 with runc v1.2.5-debug

* dqd:
  * ssst0n3/docker_archive:docker-v28.0.4 -> ssst0n3/docker_archive:docker-v28.0.4_v0.1.0
  * ssst0n3/docker_archive:docker-v28.0.4_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.0.4 -> ssst0n3/docker_archive:ctr_docker-v28.0.4_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_v0.1.0

## usage

```shell
$ cd docker/v28.0.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           28.0.4
 API version:       1.48
 Go version:        go1.23.7
 Git commit:        b8034c0
 Built:             Tue Mar 25 15:07:16 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.0.4
  API version:      1.48 (minimum version 1.24)
  Go version:       go1.23.7
  Git commit:       6430e49
  Built:            Tue Mar 25 15:07:16 2025
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
make all DIR=docker/v28.0.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.0.4_v0.1.0
```