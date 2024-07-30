# ubuntu-18.04_docker-v23.0.6_aufs

* dqd: ssst0n3/docker_archive:ubuntu-18.04_docker-v23.0.6_aufs_v0.1.0

## usage

```shell
cd docker/ubuntu-18.04_docker-v23.0.6_aufs
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 18236 root@127.0.0.1
```

```shell
root@localhost:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.10.4
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.17.3
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 23.0.6
 Storage Driver: aufs
  Root Dir: /var/lib/docker/aufs
  Backing Filesystem: extfs
  Dirs: 0
  Dirperm1 Supported: true
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 1
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 3dce8eb055cbb6872793272b4f20ed16117344f8
 runc version: v1.1.7-0-g860f061
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: builtin
 Kernel Version: 4.15.0-213-generic
 Operating System: Ubuntu 18.04.6 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.946GiB
 Name: localhost.localdomain
 ID: 5daf39fb-8fbe-4d3a-9c0c-7c693af9b54c
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

WARNING: No swap limit support

WARNING: The aufs storage-driver is deprecated, and will be removed in a future release.
         Refer to the documentation for more information: https://docs.docker.com/go/storage-driver/
```

## build

```shell
make all DIR=docker/ubuntu-18.04_docker-v23.0.6_aufs
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_ubuntu-18.04_docker-v23.0.6_aufs_v0.1.0
```