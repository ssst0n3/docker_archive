# docker v1.0.1

* dqd:
    * ssst0n3/docker_archive:docker-v1.0.1 -> ssst0n3/docker_archive:docker-v1.0.1_v0.1.0
    * ssst0n3/docker_archive:docker-v1.0.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v1.0.1 -> ssst0n3/docker_archive:ctr_docker-v1.0.1_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v1.0.1_v0.1.0

## usage

```shell
cd docker/v1.0.1
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 14101 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 1.0.1
Client API version: 1.12
Go version (client): go1.2.1
Git commit (client): 990021a
Server version: 1.0.1
Server API version: 1.12
Go version (server): go1.2.1
Git commit (server): 990021a
```

## build

```shell
make all DIR=docker/v1.0.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v1.0.1_v0.1.0
```