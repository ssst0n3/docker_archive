# docker v20.10.19

* dqd:
  * ssst0n3/docker_archive:docker-v20.10.19 -> ssst0n3/docker_archive:docker-v20.10.19_v0.1.0
  * ssst0n3/docker_archive:docker-v20.10.19_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v20.10.19 -> ssst0n3/docker_archive:ctr_docker-v20.10.19_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v20.10.19_v0.1.0

## usage

```shell
$ cd docker/v20.10.19
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           20.10.19
 API version:       1.41
 Go version:        go1.18.7
 Git commit:        d85ef84
 Built:             Thu Oct 13 16:46:58 2022
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.19
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.18.7
  Git commit:       c964641
  Built:            Thu Oct 13 16:44:47 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.8
  GitCommit:        9cd3357b7fd7218e4aec3eae239db1f68a5a6ec6
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
root@localhost:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
root@localhost:~# uname -a
Linux localhost.localdomain 5.15.0-143-generic #153-Ubuntu SMP Fri Jun 13 19:10:45 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=docker/v20.10.19
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v20.10.19_v0.1.0
```
