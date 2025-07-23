# docker v28.0.1

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
root@docker-28-0-0-rc-1:~# docker version
Client: Docker Engine - Community
 Version:           28.0.0-rc.1
 API version:       1.48
 Go version:        go1.23.6
 Git commit:        bf65a46
 Built:             Thu Feb  6 20:19:16 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.0.0-rc.1
  API version:      1.48 (minimum version 1.24)
  Go version:       go1.23.6
  Git commit:       6c37979
  Built:            Thu Feb  6 20:19:16 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.25
  GitCommit:        bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
 runc:
  Version:          1.2.4
  GitCommit:        v1.2.4-0-g6c52b3f
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
root@docker-28-0-0-rc-1:~# 
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
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 28.0.0-rc.1
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: trueroot@localhost:~# docker version
Client: Docker Engine - Community
 Version:           28.0.1
 API version:       1.48
 Go version:        go1.23.6
 Git commit:        068a01e
 Built:             Wed Feb 26 10:41:12 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          28.0.1
  API version:      1.48 (minimum version 1.24)
  Go version:       go1.23.6
  Git commit:       bbd0a17
  Built:            Wed Feb 26 10:41:12 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.25
  GitCommit:        bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
 runc:
  Version:          1.2.4
  GitCommit:        v1.2.4-0-g6c52b3f
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
root@localhost:~# containerd --version
containerd containerd.io 1.7.25 bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
root@localhost:~# cat /etc/os-release
PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
root@localhost:~# uname -a
Linux localhost.localdomain 6.8.0-64-generic #67-Ubuntu SMP PREEMPT_DYNAMIC Sun Jun 15 20:23:31 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
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
 ID: 2e94ca7f-8201-4594-b00f-88ad6bcb8225
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
