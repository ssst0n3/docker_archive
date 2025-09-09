# docker v28.0.4 centos stream9

* dqd:
  * ssst0n3/docker_archive:docker-v28.0.4_centos-stream9 -> ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_v0.2.0
  * ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_v0.2.0
  * ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9 -> ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.2.0
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.2.0: bump base image to v0.2.0
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.1.0

## usage

```shell
$ cd docker/v28.0.4_centos-stream9
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
[root@docker-28-0-4-centos-stream9 ~]# docker run -ti hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
17eec7bbc9d7: Pull complete 
Digest: sha256:a0dfb02aac212703bfcb339d77d47ec32c8706ff250850ecc0e19c8737b18567
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
...
```

```shell
$ ./ssh
[root@docker-28-0-4-centos-stream9 ~]# docker version
Client: Docker Engine - Community
 Version:           28.0.4
 API version:       1.48
 Go version:        go1.23.7
 Git commit:        b8034c0
 Built:             Tue Mar 25 15:08:34 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.0.4
  API version:      1.48 (minimum version 1.24)
  Go version:       go1.23.7
  Git commit:       6430e49
  Built:            Tue Mar 25 15:06:50 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.27
  GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
 runc:
  Version:          1.2.5
  GitCommit:        v1.2.5-0-g59923ef
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
[root@docker-28-0-4-centos-stream9 ~]# docker info
Client: Docker Engine - Community
 Version:    28.0.4
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.22.0
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.34.0
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 28.0.4
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
 containerd version: 05044ec0a9a75232cad458027ca83437aae3f4da
 runc version: v1.2.5-0-g59923ef
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 5.14.0-612.el9.x86_64
 Operating System: CentOS Stream 9
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.917GiB
 Name: docker-28-0-4-centos-stream9
 ID: 76384a20-aa74-4444-9489-ddf48f2ca267
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false

[root@docker-28-0-4-centos-stream9 ~]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Memory protection checking:     actual (secure)
Max kernel policy version:      33
```

## advance

### disable SELinux

```shell
$ ./ssh
[root@docker-28-0-4-centos-stream9 ~]# sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
[root@docker-28-0-4-centos-stream9 ~]# reboot
$ ./ssh
[root@docker-28-0-4-centos-stream9 ~]# sestatus
SELinux status:                 disabled
```


## build

```shell
make all DIR=docker/v28.0.4_centos-stream9
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.2.0
```