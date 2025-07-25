# docker v20.10.13

* dqd:
  * ssst0n3/docker_archive:docker-v20.10.13 -> ssst0n3/docker_archive:docker-v20.10.13_v0.1.0
  * ssst0n3/docker_archive:docker-v20.10.13_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v20.10.13 -> ssst0n3/docker_archive:ctr_docker-v20.10.13_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v20.10.13_v0.1.0

## start up

```shell
$ cd docker/v20.10.13
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

## usage

```shell
root@docker-20-10-13:~# docker run -ti hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
e6590344b1a5: Pull complete 
Digest: sha256:ec153840d1e635ac434fab5e377081f17e0e15afab27beb3f726c3265039cfff
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
...
```

## environment details

```shell
root@docker-20-10-13:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Docker Buildx (Docker Inc., v0.8.0-docker)
  scan: Docker Scan (Docker Inc., v0.23.0)

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 20.10.13
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 io.containerd.runtime.v1.linux runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 2a1d4dbdb2a1030dc5b01e96fb110a9d9f150ecc
 runc version: v1.0.3-0-gf46b6ba
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: default
  cgroupns
 Kernel Version: 5.15.0-144-generic
 Operating System: Ubuntu 22.04.5 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.918GiB
 Name: docker-20-10-13
 ID: FMRF:JIES:IR2V:2SGY:HOLR:Z42T:7QFS:PS5Y:MHWN:MRUD:LDQO:HGAD
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

root@docker-20-10-13:~# containerd --version
containerd containerd.io 1.5.10 2a1d4dbdb2a1030dc5b01e96fb110a9d9f150ecc
```

## build

```shell
make all DIR=docker/v20.10.13
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v20.10.13_v0.1.0
```
