# docker v23.0.3

* dqd:
  * ssst0n3/docker_archive:docker-v23.0.3 -> ssst0n3/docker_archive:docker-v23.0.3_v0.1.0
  * ssst0n3/docker_archive:docker-v23.0.3_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v23.0.3 -> ssst0n3/docker_archive:ctr_docker-v23.0.3_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v23.0.3_v0.1.0

## start up

```shell
$ cd docker/v23.0.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

## usage

```shell
root@docker-23-0-3:~# docker run -ti hello-world
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
root@docker-23-0-3:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.10.4
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.17.2
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 23.0.3
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
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1e1ea6e986c6c86565bc33d52e34b81b3e2bc71f
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
 Name: docker-23-0-3
 ID: 0a899f08-7b07-4864-8dbe-4cb092b0312b
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

root@docker-23-0-3:~# containerd --version
containerd containerd.io 1.6.19 1e1ea6e986c6c86565bc33d52e34b81b3e2bc71f
```

## build

```shell
make all DIR=docker/v23.0.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v23.0.3_v0.1.0
```
