# docker v1.12.5

* dqd:
    * ssst0n3/docker_archive:docker-v1.12.5 -> ssst0n3/docker_archive:docker-v1.12.5_v0.1.0
    * ssst0n3/docker_archive:docker-v1.12.5_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v1.12.5 -> ssst0n3/docker_archive:ctr_docker-v1.12.5_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v1.12.5_v0.1.0

## usage

```shell
$ cd docker/v1.12.5
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
root@localhost:~# docker --version
Docker version 1.12.5, build 7392c3b
root@localhost:~# docker-containerd --version
containerd version 0.2.4 commit: 2a5e70cbf65457815ee76b7e5dd2a01292d9eca8
root@localhost:~# docker-runc --version
runc version 1.0.0-rc2
commit: f59ba3cdd76fdc08c004f42aa915996f6f420899
spec: 1.0.0-rc2-dev
root@localhost:~# docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 1.12.5
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 0
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: host bridge overlay null
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
ID: K2GL:AVHT:5DU2:42GM:O6YA:25XI:5UG6:LNTO:YTI2:UP67:2ICL:SPEA
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
make all DIR=docker/v1.12.5
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v1.12.5_v0.1.0
```
