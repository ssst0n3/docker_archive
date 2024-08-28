# docker v0.7.1

* dqd: ssst0n3/docker_archive:docker-v0.7.1_v0.1.0

## usage

```shell
cd docker/v0.7.1
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 12710 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.7.1
Go version (client): go1.2
Git commit (client): 88df052
Server version: 0.7.1
Git commit (server): 88df052
Go version (server): go1.2
Last stable version: 17.05.0-ce, please update docker
root@localhost:~# lxc-version 
lxc version: 0.7.5
```

## build

```shell
make all DIR=docker/v0.7.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v0.7.1_v0.1.0
```