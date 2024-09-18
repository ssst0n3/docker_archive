# runc v1.0.0-rc2

* dqd
    * ssst0n3/docker_archive:runc-v1.0.0-rc2-dbg (-> ssst0n3/docker_archive:runc-v1.0.0-rc2-dbg_v0.1.0)
    * ssst0n3/docker_archive:runc-v1.0.0-rc2-dbg_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg (-> ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.1.0)
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.1.0

## usage

```shell
cd runc/v1.0.0-rc2-dbg
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@localhost:~# runc run container-1


BusyBox v1.22.1 (Ubuntu 1:1.22.0-15ubuntu1.4) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```

## build

```shell
make all DIR=runc/v1.0.0-rc2-dbg
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.1.0
```