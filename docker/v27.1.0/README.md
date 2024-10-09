# docker v27.1.0

* dqd:
  * ssst0n3/docker_archive:docker-v27.1.0 -> ssst0n3/docker_archive:docker-v27.1.0_v0.1.0
  * ssst0n3/docker_archive:docker-v27.1.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v27.1.0 -> ssst0n3/docker_archive:ctr_docker-v27.1.0_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v27.1.0_v0.1.0

## usage

```shell
cd docker/v27.1.0
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 27100 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client: Docker Engine - Community
 Version:           27.1.0
 API version:       1.46
 Go version:        go1.21.12
 Git commit:        6312585
 Built:             Fri Jul 19 17:42:42 2024
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          27.1.0
  API version:      1.46 (minimum version 1.24)
  Go version:       go1.21.12
  Git commit:       a21b1a2
  Built:            Fri Jul 19 17:42:42 2024
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.20
  GitCommit:        8fc6bcff51318944179630522a095cc9dbf9f353
 runc:
  Version:          1.1.13
  GitCommit:        v1.1.13-0-g58aa920
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

## build

```shell
make all DIR=docker/v27.1.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v27.1.0_v0.1.0
```