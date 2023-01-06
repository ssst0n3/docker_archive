# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-22.04_docker-ce-20.10.21_docker-ce-cli-20.10.21_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1`

## usage
### with kvm
```
docker network create test
docker run --net=test --dev /dev/kvm -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-22.04_docker-ce-20.10.21_docker-ce-cli-20.10.21_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 /start_vm.sh -enable-kvm
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           20.10.21
 API version:       1.41
 Go version:        go1.18.7
 Git commit:        baeda1f
 Built:             Tue Oct 25 18:01:58 2022
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.21
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.18.7
  Git commit:       3056208
  Built:            Tue Oct 25 17:59:49 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.14
  GitCommit:        9ba4b250366a5ddde94bb7c9d1def331423aa323
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

### without kvm
```
docker network create test
docker run --net=test -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-22.04_docker-ce-20.10.21_docker-ce-cli-20.10.21_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

or 

```
docker-compose up -d
```

## info
```
root@docker-archive:~# ssh -p 2222 127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Docker Buildx (Docker Inc., v0.9.1-docker)
  compose: Docker Compose (Docker Inc., v2.14.1)
  scan: Docker Scan (Docker Inc., v0.23.0)

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 20.10.21
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
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
 Runtimes: io.containerd.runc.v2 io.containerd.runtime.v1.linux runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 9ba4b250366a5ddde94bb7c9d1def331423aa323
 runc version: v1.1.4-0-g5fd4c4d
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: default
  cgroupns
 Kernel Version: 5.15.0-37-generic
 Operating System: Ubuntu 22.04 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.931GiB
 Name: ubuntu
 ID: QWP7:2KVY:ESH3:D5Y3:ICI2:MIZW:GYMT:DYXA:PKO6:NAI6:KZWC:JGWC
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

```
root@ubuntu:~# git --version
git version 2.34.1
```