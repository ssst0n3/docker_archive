# docker v23.0.0

* dqd:
  * ssst0n3/docker_archive:docker-v23.0.0 -> ssst0n3/docker_archive:docker-v23.0.0_v0.1.0
  * ssst0n3/docker_archive:docker-v23.0.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v23.0.0 -> ssst0n3/docker_archive:ctr_docker-v23.0.0_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v23.0.0_v0.1.0

## start up

```shell
$ cd docker/v23.0.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

## usage

```shell
root@docker-23-0-0:~# docker run -ti hello-world
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
root@docker-23-0-0:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.10.2
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.15.1
    Path:     /usr/libexec/docker/cli-plugins/docker-compose
  scan: Docker Scan (Docker Inc.)
    Version:  v0.23.0
    Path:     /usr/libexec/docker/cli-plugins/docker-scan

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 23.0.0
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Using metacopy: false
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
 Runtimes: runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 31aa4358a36870b21a992d3ad2bef29e1d693bec
 runc version: v1.1.4-0-g5fd4c4d
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 5.15.0-144-generic
 Operating System: Ubuntu 22.04.5 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.918GiB
 Name: docker-23-0-0
 ID: 0809d724-f3f3-48b2-bf89-90e26a5f3eca
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

root@docker-23-0-0:~# containerd --version
containerd containerd.io 1.6.16 31aa4358a36870b21a992d3ad2bef29e1d693bec
```

## build

```shell
make all DIR=docker/v23.0.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v23.0.0_v0.1.0
```
