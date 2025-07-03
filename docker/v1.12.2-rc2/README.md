# docker v1.12.2-rc2

* dqd:
    * ssst0n3/docker_archive:docker-v1.12.2-rc2 -> ssst0n3/docker_archive:docker-v1.12.2-rc2_v0.1.0
    * ssst0n3/docker_archive:docker-v1.12.2-rc2_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_docker-v1.12.2-rc2 -> ssst0n3/docker_archive:ctr_docker-v1.12.2-rc2_v0.1.0
    * ssst0n3/docker_archive:ctr_docker-v1.12.2-rc2_v0.1.0

## usage

```shell
$ cd docker/v1.12.2-rc2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
root@localhost:~# docker --version
Docker version 1.12.2-rc2, build ad9538a
root@localhost:~# docker-containerd --version
containerd version 0.2.4 commit: 71861281661331fbc81936be81f05d8db71fc1ca
root@localhost:~# docker-runc --version
runc version 1.0.0-rc1
commit: cc29e3dded8e27ba8f65738f40d251c885030a28
spec: 1.0.0-rc1
root@localhost:~# docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 1.12.2-rc2
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 0
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: overlay bridge null host
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
ID: VEOZ:SFIO:A6YU:OURR:IXAQ:Z3RT:NDNO:RDTA:6EPN:6XJF:BXQL:5JMF
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
make all DIR=docker/v1.12.2-rc2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v1.12.2-rc2_v0.1.0
```
