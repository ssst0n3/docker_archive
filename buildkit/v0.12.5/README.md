# buildkit v0.12.5

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.12.5 -> ssst0n3/docker_archive:buildkit-v0.12.5_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.12.5_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.5 -> ssst0n3/docker_archive:ctr_buildkit-v0.12.5_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.5_v0.1.0

## usage

```shell
$ cd buildkit/v0.12.5
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@buildkit-0-12-5:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-12-5:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 60B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/ubuntu:latest
#2 DONE 6.4s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
...
#4 DONE 11.9s

#5 [2/2] RUN echo 1
#5 0.083 1
#5 DONE 0.2s
```

```shell
$ ./ssh
root@buildkit-0-12-5:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.5 bac3f2b673f3f9d33e79046008e7a38e856b3dc6
root@buildkit-0-12-5:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
root@buildkit-0-12-5:~# systemctl status
● buildkit-0-12-5
    State: running
    Units: 307 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Tue 2025-08-26 02:49:43 UTC; 2min 21s ago
  systemd: 255.4-1ubuntu8.10
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─buildkit.service
           │ │ └─288 /usr/local/bin/buildkitd --addr fd://
           │ ├─dbus.service
           │ │ └─290 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
           │ ├─ssh.service
           │ │ └─302 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─304 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─305 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-journald.service
           │ │ └─188 /usr/lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─294 /usr/lib/systemd/systemd-logind
           │ ├─systemd-networkd.service
           │ │ └─271 /usr/lib/systemd/systemd-networkd
           │ ├─systemd-resolved.service
           │ │ └─255 /usr/lib/systemd/systemd-resolved
           │ ├─systemd-timesyncd.service
           │ │ └─256 /usr/lib/systemd/systemd-timesyncd
           │ └─systemd-udevd.service
           │   └─udev
           │     └─247 /usr/lib/systemd/systemd-udevd
           └─user.slice
             └─user-0.slice
               ├─session-1.scope
               │ ├─337 "sshd: root@pts/0"
               │ ├─360 -bash
               │ ├─441 systemctl status
               │ └─442 pager
               └─user@0.service
                 └─init.scope
                   ├─342 /usr/lib/systemd/systemd --user
                   └─343 "(sd-pam)"
```

## build

```shell
make all DIR=buildkit/v0.12.5
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.12.5_v0.1.0
```
