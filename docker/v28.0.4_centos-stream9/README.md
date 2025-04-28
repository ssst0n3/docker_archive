# docker v28.0.4 centos stream9

* dqd:
  * ssst0n3/docker_archive:docker-v28.0.4_centos-stream9 -> ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_v0.1.0
  * ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9 -> ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.1.0

## usage

```shell
$ cd docker/v28.0.4_centos-stream9
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

```shell
[root@localhost ~]# docker version
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

[root@localhost ~]# docker info
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
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
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
 Runtimes: runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 05044ec0a9a75232cad458027ca83437aae3f4da
 runc version: v1.2.5-0-g59923ef
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 5.14.0-575.el9.x86_64
 Operating System: CentOS Stream 9
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.917GiB
 Name: localhost.localdomain
 ID: 1e887c54-ea45-43d0-b4f7-ade941e63958
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false

[root@localhost ~]# sestatus 
SELinux status:                 disabled
```

## advance

### enable SELinux

```shell
$ ./ssh
[root@localhost ~]# sestatus 
SELinux status:                 disabled
[root@localhost ~]# sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config
[root@localhost ~]# touch /.autorelabel
[root@localhost ~]# reboot
$ ./ssh
[root@localhost ~]# sestatus 
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


## build

```shell
make all DIR=docker/v28.0.4_centos-stream9
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_v0.1.0
```