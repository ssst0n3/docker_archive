# docker v27.5.1

* dqd:
  * ssst0n3/docker_archive:docker-v27.5.1 -> ssst0n3/docker_archive:docker-v27.5.1_v0.2.0
  * ssst0n3/docker_archive:docker-v27.5.1_v0.2.0
  * ssst0n3/docker_archive:docker-v27.5.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v27.5.1 -> ssst0n3/docker_archive:ctr_docker-v27.5.1_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v27.5.1_v0.2.0: bump the base image; update the depencies version
  * ssst0n3/docker_archive:ctr_docker-v27.5.1_v0.1.0

## usage

```shell
$ cd docker/v27.5.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
root@localhost:~# docker info
Client: Docker Engine - Community
 Version:    27.5.1
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
 Server Version: 27.5.1
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
 Name: localhost.localdomain
 ID: 34670afe-e369-4f8d-b103-da4ed19ea60c
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

## build

```shell
make all DIR=docker/v27.5.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v27.5.1_v0.2.0
```