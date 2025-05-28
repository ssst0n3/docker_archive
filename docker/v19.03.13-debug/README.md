# docker v19.03.13 with containerd v1.3.7 debug

* dqd:
  * ssst0n3/docker_archive:docker-v19.03.13_containerd-v1.3.7-debug -> ssst0n3/docker_archive:docker-v19.03.13_containerd-v1.3.7-debug_v0.1.0
  * ssst0n3/docker_archive:docker-v19.03.13_containerd-v1.3.7-debug_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v19.03.13_containerd-v1.3.7-debug -> ssst0n3/docker_archive:ctr_docker-v19.03.13_containerd-v1.3.7-debug_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v19.03.13_containerd-v1.3.7-debug_v0.1.0

## usage

```shell
$ cd docker/v19.03.13-debug
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### debug-ports

- 19311: runc main
- 19312: runc init
- 19313: dockerd 
- 19314: docker; not avaiable now, preservce
- 19315: containerd
- 19316: containerd-shim
- 19317: containerd-shim-runc-v1
- 19328: containerd-shim-runc-v2
- 19329: ctr

### containerd debug

```shell
$ ./ssh
root@localhost:~# systemctl stop containerd
root@localhost:~# ln -sf /usr/local/bin/debug.sh /usr/bin/containerd
root@localhost:~# ln -sf /usr/local/bin/debug.sh /usr/bin/containerd-shim
root@localhost:~# containerd -c /etc/containerd/config.toml -l debug
API server listening at: [::]:2345
INFO[2025-05-27T07:06:50.900884370Z] starting containerd                           revision=8d1927372a8eba375f8d44a0b756c59052e3ca6f.m version=v1.3.7-5-g8d19273.m
...
```

### docker debug

```shell
$ ./ssh
root@localhost:~# systemctl stop docker
root@localhost:~# ln -sf /usr/local/bin/debug.sh /usr/bin/dockerd
root@localhost:~# dockerd -D
API server listening at: [::]:2343
INFO[2025-05-27T07:01:40.801135849Z] Starting up 
...
```

### runc debug

runc main

```shell
$ ./ssh
root@localhost:~# ln -sf /usr/local/bin/debug.sh /usr/bin/runc
```

```shell
$ ./ssh
root@localhost:~# ps -ef |grep runc |grep init
root@localhost:~# attach.sh [PID]
```

### env

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
make all DIR=docker/v19.03.13-debug
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v19.03.13-debug_v0.1.0
```
