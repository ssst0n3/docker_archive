# docker v28.0.0-rc.1

* dqd:
  * ssst0n3/docker_archive:docker-v28.0.0-rc.1 -> ssst0n3/docker_archive:docker-v28.0.0-rc.1_v0.1.0
  * ssst0n3/docker_archive:docker-v28.0.0-rc.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.0.0-rc.1 -> ssst0n3/docker_archive:ctr_docker-v28.0.0-rc.1_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v28.0.0-rc.1_v0.1.0

## usage

```shell
$ cd docker/v28.0.0-rc.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@docker-28-0-0-rc-1:~# docker run -ti hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
e6590344b1a5: Pull complete 
Digest: sha256:ec153840d1e635ac434fab5e377081f17e0e15afab27beb3f726c3265039cfff
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
...
```

```shell
$ ./ssh
root@docker-28-0-0-rc-1:~# docker info
Client: Docker Engine - Community
 Version:    28.0.0-rc.1
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.20.0
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.32.4
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 28.0.0-rc.1
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
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
 runc version: v1.2.4-0-g6c52b3f
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.8.0-64-generic
 Operating System: Ubuntu 24.04.2 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.922GiB
 Name: docker-28-0-0-rc-1
 ID: 003a23cd-ccbe-4245-9f7d-0fbae42a8018
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
```

## build

```shell
make all DIR=docker/v28.0.0-rc.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.0.0-rc.1_v0.1.0
```
