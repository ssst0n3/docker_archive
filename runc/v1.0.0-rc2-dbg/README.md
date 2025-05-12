# runc v1.0.0-rc2-dbg

* dqd
    * ssst0n3/docker_archive:runc-v1.0.0-rc2-dbg -> ssst0n3/docker_archive:runc-v1.0.0-rc2-dbg_v0.2.0
    * ssst0n3/docker_archive:runc-v1.0.0-rc2-dbg_v0.2.0
    * ssst0n3/docker_archive:runc-v1.0.0-rc2-dbg_v0.1.0
* ctr
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg -> ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.2.0
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.2.0: bump the base image; update debug files
    * ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.1.0

## usage

```shell
$ cd runc/v1.0.0-rc2-dbg
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### 1. debug the runc main

start a runc command

```shell
root@localhost:~# runc --version
API server listening at: [::]:2346
2025-05-12T13:54:45Z warning layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
....
```

connect it by dlv or a IDE

```shell
$ dlv connect 127.0.0.1:10026
Type 'help' for list of commands.
(dlv) c
Process 398 has exited with status 0
```

```shell
root@localhost:~# runc --version
API server listening at: [::]:2346
2025-05-12T13:54:45Z warning layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
runc version 1.0.0-rc2
commit: c91b5bea4830a57eac7882d7455d59518cdf70ec-dirty
spec: 1.0.0-rc2-dev
```

### 2. debug the runc init

run a container, and connect it by dlv or a IDE

```shell
$ ./ssh
root@localhost:~# runc run container-1
API server listening at: [::]:2346
2025-05-12T13:48:31Z warning layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
...
```

and then attach the init process

```shell
root@localhost:~# ps -ef |grep init
root         1     0  0 12:57 ?        00:00:00 /sbin/init
root       457   450  0 13:05 pts/2    00:00:00 ./fd-listener_linux_amd64 -a /proc/self/exe -a init -d bundle
root       469   419  0 13:05 ?        00:00:00 /proc/self/exe init
root       476   406  0 13:05 pts/1    00:00:00 grep --color=auto init
root@localhost:~# attach.sh 469
API server listening at: [::]:2347
2025-05-12T13:51:15Z warning layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
...
```

## build

```shell
make all DIR=runc/v1.0.0-rc2-dbg
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_runc-v1.0.0-rc2-dbg_v0.2.0
```
