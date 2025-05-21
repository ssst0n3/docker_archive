# docker v19.03.13 for e2e test env

* dqd:
  * ssst0n3/docker_archive:docker-v19.03.13-e2e -> ssst0n3/docker_archive:docker-v19.03.13-e2e_v0.1.0
  * ssst0n3/docker_archive:docker-v19.03.13-e2e_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v19.03.13-e2e -> ssst0n3/docker_archive:ctr_docker-v19.03.13-e2e_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v19.03.13-e2e_v0.1.0

## usage

```shell
$ cd docker/v19.03.13-e2e
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           19.03.13
 API version:       1.40
 Go version:        go1.13.15
 Git commit:        4484c46d9d
 Built:             Wed Sep 16 17:02:52 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.13
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       4484c46d9d
  Built:            Wed Sep 16 17:01:20 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.3.7
  GitCommit:        8fba4e9a7d01810a393d5d25a3621dc101981175
 runc:
  Version:          1.0.0-rc10
  GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
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
root@localhost:~# uname -a
Linux localhost.localdomain 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=docker/v19.03.13-e2e
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v19.03.13-e2e_v0.1.0
```
