# docker v1.12.3

* dqd:
    * ssst0n3/docker_archive:docker-v1.12.3 -> ssst0n3/docker_archive:docker-v1.12.3_v0.1.0
    * ssst0n3/docker_archive:docker-v1.12.3_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v1.12.3 -> ssst0n3/docker_archive:ctr_docker-v1.12.3_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v1.12.3_v0.1.0

## usage

```shell
$ cd docker/v1.12.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
root@localhost:~# docker --version
Docker version 1.12.3, build 6b644ec
root@localhost:~# docker-containerd --version
containerd version 0.2.4 commit: b818e749726ba18e430bb825396c85408dfaf2a4
root@localhost:~# docker-runc --version
runc version 1.0.0-rc2
commit: f59ba3cdd76fdc08c004f42aa915996f6f420899
spec: 1.0.0-rc2-dev
root@localhost:~# docker info
Containers: 1
 Running: 0
 Paused: 0
 Stopped: 1
Images: 1
Server Version: 1.12.3
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 6
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
ID: X72N:OH35:SWDQ:T2XL:CQXC:5BNH:R5H4:SS2B:KTZM:ERZB:VBIM:KFDG
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
make all DIR=docker/v1.12.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v1.12.3_v0.1.0
```
