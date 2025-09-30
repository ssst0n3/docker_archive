# docker v23.0.0 with devicemapper

* dqd:
  * ssst0n3/docker_archive:docker-v23.0.0-devicemapper -> ssst0n3/docker_archive:docker-v23.0.0-devicemapper_v0.1.0
  * ssst0n3/docker_archive:docker-v23.0.0-devicemapper_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v23.0.0-devicemapper -> ssst0n3/docker_archive:ctr_docker-v23.0.0-devicemapper_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v23.0.0-devicemapper_v0.1.0

## start up

```shell
$ cd docker/v23.0.0-devicemapper
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

## usage

```shell
root@docker-23-0-0-devicemapper:~# docker run -ti hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
17eec7bbc9d7: Pull complete 
Digest: sha256:54e66cc1dd1fcb1c3c58bd8017914dbed8701e2d8c74d9262e26bd9cc1642d31
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
...
```

## environment details

```shell
root@docker-23-0-0-devicemapper:~# docker info
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
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 23.0.0
 Storage Driver: devicemapper
  Pool Name: docker-8:1-132677-pool
  Pool Blocksize: 65.54kB
  Base Device Size: 10.74GB
  Backing Filesystem: ext4
  Udev Sync Supported: true
  Data file: /dev/loop0
  Metadata file: /dev/loop1
  Data loop file: /var/lib/docker/devicemapper/devicemapper/data
  Metadata loop file: /var/lib/docker/devicemapper/devicemapper/metadata
  Data Space Used: 240.1MB
  Data Space Total: 107.4GB
  Data Space Available: 9.116GB
  Metadata Space Used: 17.43MB
  Metadata Space Total: 2.147GB
  Metadata Space Available: 2.13GB
  Thin Pool Minimum Free Space: 10.74GB
  Deferred Removal Enabled: true
  Deferred Deletion Enabled: true
  Deferred Deleted Device Count: 0
  Library Version: 1.02.175 (2021-01-08)
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
 containerd version: 31aa4358a36870b21a992d3ad2bef29e1d693bec
 runc version: v1.1.4-0-g5fd4c4d
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 5.15.0-156-generic
 Operating System: Ubuntu 22.04.5 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.918GiB
 Name: docker-23-0-0-devicemapper
 ID: 266206ad-6aee-4beb-9372-7ddafc0b8d29
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false


WARNING: The devicemapper storage-driver is deprecated, and will be removed in a future release.
         Refer to the documentation for more information: https://docs.docker.com/go/storage-driver/
WARNING: devicemapper: usage of loopback devices is strongly discouraged for production use.
         Use `--storage-opt dm.thinpooldev` to specify a custom block storage device.

root@docker-23-0-0-devicemapper:~# containerd --version
containerd containerd.io 1.6.16 31aa4358a36870b21a992d3ad2bef29e1d693bec
```

## build

```shell
make all DIR=docker/v23.0.0-devicemapper
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v23.0.0-devicemapper_v0.1.0
```
