# docker v28.0.0

* dqd:
  * ssst0n3/docker_archive:docker-v28.0.0 -> ssst0n3/docker_archive:docker-v28.0.0_v0.1.0
  * ssst0n3/docker_archive:docker-v28.0.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.0.0 -> ssst0n3/docker_archive:ctr_docker-v28.0.0_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v28.0.0_v0.1.0

## usage

```shell
cd docker/v28.0.0
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 28000 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           28.0.0
 API version:       1.48
 Go version:        go1.23.6
 Git commit:        f9ced58
 Built:             Wed Feb 19 22:11:04 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.0.0
  API version:      1.48 (minimum version 1.24)
  Go version:       go1.23.6
  Git commit:       af898ab
  Built:            Wed Feb 19 22:11:04 2025
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
make all DIR=docker/v28.0.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.0.0_v0.1.0
```