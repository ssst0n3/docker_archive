# docker v1.12.1

* dqd:
    * ssst0n3/docker_archive:docker-v1.12.1 -> ssst0n3/docker_archive:docker-v1.12.1_v0.1.0
    * ssst0n3/docker_archive:docker-v1.12.1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v1.12.1 -> ssst0n3/docker_archive:ctr_docker-v1.12.1_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v1.12.1_v0.1.0

## usage

```shell
$ cd docker/v1.12.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
root@localhost:~# docker --version
Docker version 1.12.1, build 23cf638
root@localhost:~# docker-containerd --version
containerd version 0.2.0 commit: 0ac3cd1be170d180b2baed755e8f0da547ceb267
root@localhost:~# docker-runc --version
runc version 1.0.0-rc1
commit: cc29e3dded8e27ba8f65738f40d251c885030a28
spec: 1.0.0-rc1
root@localhost:~# docker info
Containers: 3
 Running: 0
 Paused: 0
 Stopped: 3
Images: 1
Server Version: 1.12.1
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 10
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: null host bridge overlay
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Security Options: apparmor seccomp
Kernel Version: 4.4.0-210-generic
Operating System: Ubuntu 16.04.7 LTS
OSType: linux
Architecture: x86_64
CPUs: 2
Total Memory: 1.953 GiB
Name: localhost.localdomain
ID: IXKA:57T4:LAH7:LHIF:EEPV:ZMNB:NKBX:RXQQ:KHGO:L77F:7XHC:DGK2
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
WARNING: No swap limit support
Insecure Registries:
 127.0.0.0/8
```

```shell
root@localhost:~# docker run -ti ubuntu:16.04 id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=docker/v1.12.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v1.12.1_v0.1.0
```
