# docker v28.0.4 centos stream9 with runc v1.2.5 debug

* dqd:
  * ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_runc-v1.2.5-debug -> ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_runc-v1.2.5-debug_v0.1.0
  * ssst0n3/docker_archive:docker-v28.0.4_centos-stream9_runc-v1.2.5-debug_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_runc-v1.2.5-debug -> ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_runc-v1.2.5-debug_v0.1.0
  * ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_runc-v1.2.5-debug_v0.1.0

## usage

```shell
$ cd docker/v28.0.4_centos-stream9
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### debug

see [v28.0.4-debug/DEBUG.md](../v28.0.4-debug/DEBUG.md) as a reference.

### env information

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
 Kernel Version: 5.14.0-580.el9.x86_64
 Operating System: CentOS Stream 9
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.917GiB
 Name: localhost.localdomain
 ID: 20ced15f-6752-475a-9974-cc183a9d8283
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false

[root@localhost ~]# cat /etc/os-release 
NAME="CentOS Stream"
VERSION="9"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="9"
PLATFORM_ID="platform:el9"
PRETTY_NAME="CentOS Stream 9"
ANSI_COLOR="0;31"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:centos:centos:9"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://issues.redhat.com/"
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 9"
REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream"
[root@localhost ~]# uname -a
Linux localhost.localdomain 5.14.0-580.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Apr 22 20:29:48 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
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

## advance

### disable SELinux

```shell
$ ./ssh
[root@localhost ~]# sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
[root@localhost ~]# reboot
$ ./ssh
[root@localhost ~]# sestatus 
SELinux status:                 disabled
```


## build

```shell
make all DIR=docker/v28.0.4_centos-stream9_runc-v1.2.5-debug
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_docker-v28.0.4_centos-stream9_runc-v1.2.5-debug_v0.1.0
```