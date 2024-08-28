# docker v23.0.6

* dqd:
  * ssst0n3/docker_archive:ubuntu-22.04_docker-v23.0.6 -> ssst0n3/docker_archive:ubuntu-22.04_docker-v23.0.6_v0.1.0
  * ssst0n3/docker_archive:ubuntu-22.04_docker-v23.0.6_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_ubuntu-22.04_docker-v23.0.6 -> ssst0n3/docker_archive:ctr_ubuntu-22.04_docker-v23.0.6_v0.1.0
  * ssst0n3/docker_archive:ctr_ubuntu-22.04_docker-v23.0.6_v0.1.0

## usage

```shell
cd docker/v23.0.6
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 23060 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           23.0.6
 API version:       1.42
 Go version:        go1.19.9
 Git commit:        ef23cbc
 Built:             Fri May  5 21:18:13 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          23.0.6
  API version:      1.42 (minimum version 1.12)
  Go version:       go1.19.9
  Git commit:       9dbdbd4
  Built:            Fri May  5 21:18:13 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.21
  GitCommit:        3dce8eb055cbb6872793272b4f20ed16117344f8
 runc:
  Version:          1.1.7
  GitCommit:        v1.1.7-0-g860f061
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

## build

```shell
make all DIR=docker/v23.0.6
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-22.04_docker-v23.0.6_v0.1.0
```