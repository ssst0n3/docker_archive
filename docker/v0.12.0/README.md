# docker v0.12.0

* dqd:
    * ssst0n3/docker_archive:docker-v0.12.0 -> ssst0n3/docker_archive:docker-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:docker-v0.12.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v0.12.0 -> ssst0n3/docker_archive:ctr_docker-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v0.12.0_v0.1.0

## usage

```shell
cd docker/v0.12.0
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 14120 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.12.0
Client API version: 1.12
Go version (client): go1.2.1
Git commit (client): 14680bf
Server version: 0.12.0
Server API version: 1.12
Go version (server): go1.2.1
Git commit (server): 14680bf
```

## build

```shell
make all DIR=docker/v0.12.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v0.12.0_v0.1.0
```