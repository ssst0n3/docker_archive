# docker v27.5.1

* dqd:
  * ssst0n3/docker_archive:docker-v27.5.1 -> ssst0n3/docker_archive:docker-v27.5.1_v0.1.0
  * ssst0n3/docker_archive:docker-v27.5.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v27.5.1 -> ssst0n3/docker_archive:ctr_docker-v27.5.1_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v27.5.1_v0.1.0

## usage

```shell
cd docker/v27.5.1
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 27510 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           27.5.1
 API version:       1.47
 Go version:        go1.22.11
 Git commit:        9f9e405
 Built:             Wed Jan 22 13:41:48 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          27.5.1
  API version:      1.47 (minimum version 1.24)
  Go version:       go1.22.11
  Git commit:       4c9b3b0
  Built:            Wed Jan 22 13:41:48 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.25
  GitCommit:        bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
 runc:
  Version:          1.2.4
  GitCommit:        v1.2.4-0-g6c52b3f
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

## build

```shell
make all DIR=docker/v27.5.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v27.5.1_v0.1.0
```