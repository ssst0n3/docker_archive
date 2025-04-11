# buildkit v0.20.2

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.20.2 -> ssst0n3/docker_archive:buildkit-v0.20.2_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.20.2_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.20.2 -> ssst0n3/docker_archive:ctr_buildkit-v0.20.2_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.20.2_v0.1.0

## usage

```shell
$ cd buildkit/v0.20.2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
root@localhost:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@localhost:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 60B done
#1 DONE 0.2s

#2 [internal] load metadata for docker.io/library/ubuntu:latest
#2 DONE 9.2s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:1e622c5f073b4f6bfad6632f2616c7f59ef256e96fe78bf6a595d1dc4376ac02
#4 resolve docker.io/library/ubuntu:latest@sha256:1e622c5f073b4f6bfad6632f2616c7f59ef256e96fe78bf6a595d1dc4376ac02 done
#4 sha256:2726e237d1a374379e783053d93d0345c8a3bf3c57b5d35b099de1ad777486ee 29.72MB / 29.72MB 8.4s done
#4 extracting sha256:2726e237d1a374379e783053d93d0345c8a3bf3c57b5d35b099de1ad777486ee 1.3s done
#4 DONE 9.7s

#5 [2/2] RUN echo 1
#5 0.038 1
#5 DONE 0.2s
```

```shell
$ ./ssh
root@localhost:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.20.2 97437fdd7e32f29bb80288d800cd4ffcb34e1c15
root@localhost:~# runc --version                                         
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@localhost:~# systemctl status
● localhost.localdomain
    State: running
    Units: 307 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Fri 2025-04-11 12:40:45 UTC; 5min ago
  systemd: 255.4-1ubuntu8.6
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─buildkit.service
           │ │ └─288 /usr/local/bin/buildkitd --addr fd://
           │ ├─dbus.service
           │ │ └─289 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
           │ ├─ssh.service
           │ │ └─301 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─306 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─307 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-journald.service
           │ │ └─186 /usr/lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─293 /usr/lib/systemd/systemd-logind
           │ ├─systemd-networkd.service
           │ │ └─277 /usr/lib/systemd/systemd-networkd
           │ ├─systemd-resolved.service
           │ │ └─254 /usr/lib/systemd/systemd-resolved
           │ ├─systemd-timesyncd.service
           │ │ └─255 /usr/lib/systemd/systemd-timesyncd
           │ └─systemd-udevd.service
           │   └─udev
           │     └─247 /usr/lib/systemd/systemd-udevd
           └─user.slice
             └─user-0.slice
               ├─session-1.scope
               │ ├─343 "sshd: root@pts/0"
               │ ├─366 -bash
               │ ├─504 systemctl status
               │ └─505 pager
               └─user@0.service
                 └─init.scope
                   ├─348 /usr/lib/systemd/systemd --user
                   └─349 "(sd-pam)"
```

## build

```shell
make all DIR=buildkit/v0.20.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.20.2_v0.1.0
```