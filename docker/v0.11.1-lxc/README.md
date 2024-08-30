# docker v0.11.1 lxc

* dqd:
    * ssst0n3/docker_archive:docker-v0.11.1-lxc -> ssst0n3/docker_archive:docker-v0.11.1-lxc_v0.1.0
    * ssst0n3/docker_archive:docker-v0.11.1-lxc_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v0.11.1-lxc -> ssst0n3/docker_archive:ctr_docker-v0.11.1-lxc_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v0.11.1-lxc_v0.1.0

## usage

```shell
cd docker/v0.11.1-lxc
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 11110 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.11.1
Client API version: 1.11
Go version (client): go1.2.1
Git commit (client): fb99f99
Server version: 0.11.1
Server API version: 1.11
Git commit (server): fb99f99
Go version (server): go1.2.1
Last stable version: 17.05.0-ce, please update docker  
root@localhost:~# lxc-start --version
1.0.10
```

## build

```shell
make all DIR=docker/v0.11.1-lxc
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v0.11.1-lxc_v0.1.0
```