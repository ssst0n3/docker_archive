# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## version
`ubuntu-22.04_docker-ce-20.10.19_docker-ce-cli-20.10.19_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1`

## usage
### with kvm
```
docker network create test
docker run --net=test --dev /dev/kvm -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-22.04_docker-ce-20.10.19_docker-ce-cli-20.10.19_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1 /start_vm.sh -enable-kvm
ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

### without kvm
```
docker network create test
docker run --net=test -d -p 2222:22 -ti ssst0n3/docker_archive:ubuntu-22.04_docker-ce-20.10.19_docker-ce-cli-20.10.19_containerd.io-1.6.14-1_docker-compose-plugin-2.14.1
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
  buildx: Docker Buildx (Docker Inc., v0.8.2-docker)
  compose: Docker Compose (Docker Inc., v2.6.0)
  scan: Docker Scan (Docker Inc., v0.17.0)

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 20.10.17
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
 containerd version: 10c12954828e7c7c9b6e0ea9b0c02b01407d3ae1
 runc version: v1.1.2-0-ga916309
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
 ID: NG5K:HVO7:I4AK:AYWZ:GPA3:LRWE:H3KC:KKZY:H5VL:MCF5:67U4:QADC
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```