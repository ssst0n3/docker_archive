# runc v1.1.12

* dqd: ssst0n3/docker_archive:ubuntu-22.04_runc-v1.1.12_v0.1.0

## usage

```shell
cd runc/v1.1.12
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 11120 root@127.0.0.1
```

```shell
root@localhost:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
```

## build

```shell
make all DIR=runc/v1.1.12
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-22.04_runc-v1.1.12_v0.1.0
```