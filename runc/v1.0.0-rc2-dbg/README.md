# runc v1.0.0-rc2-dbg

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
API server listening at: [::]:2345
2024-09-18T13:03:46Z warning layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
...
```

```shell
root@localhost:~# ps -ef |grep init
root         1     0  0 12:57 ?        00:00:00 /sbin/init
root       457   450  0 13:05 pts/2    00:00:00 ./fd-listener_linux_amd64 -a /proc/self/exe -a init -d bundle
root       469   419  0 13:05 ?        00:00:00 /proc/self/exe init
root       476   406  0 13:05 pts/1    00:00:00 grep --color=auto init
root@localhost:~# attach 469
API server listening at: [::]:2346
2024-09-18T13:06:02Z warning layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
...
```

## build

```shell
make all DIR=runc/v1.0.0-rc2-dbg
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.1.0
```