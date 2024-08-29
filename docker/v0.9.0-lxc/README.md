# docker v0.9.0 lxc

* dqd:
    * ssst0n3/docker_archive:docker-v0.9.0-lxc -> ssst0n3/docker_archive:docker-v0.9.0-lxc_v0.1.0
    * ssst0n3/docker_archive:docker-v0.9.0-lxc_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v0.9.0-lxc -> ssst0n3/docker_archive:ctr_docker-v0.9.0-lxc_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v0.9.0-lxc_v0.1.0

## usage

```shell
cd docker/v0.9.0-lxc
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 12091 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.9.0
Go version (client): go1.2.1
Git commit (client): 2b3fdf2
Server version: 0.9.0
Git commit (server): 2b3fdf2
Go version (server): go1.2.1
Last stable version: 17.05.0-ce, please update docker
root@localhost:~# lxc-version 
lxc version: 0.7.5
```

## build

```shell
make all DIR=docker/v0.9.0-lxc
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v0.9.0-lxc_v0.1.0
```