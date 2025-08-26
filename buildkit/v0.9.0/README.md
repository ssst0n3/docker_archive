# buildkit v0.9.0

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.9.0 -> ssst0n3/docker_archive:buildkit-v0.9.0_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.9.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.9.0 -> ssst0n3/docker_archive:ctr_buildkit-v0.9.0_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.9.0_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.9.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-9-0:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-9-0:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 60B done
#1 DONE 0.0s

#2 [internal] load .dockerignore
#2 transferring context: 2B done
#2 DONE 0.0s

#3 [internal] load metadata for docker.io/library/ubuntu:latest
#3 DONE 5.6s

#4 [1/2] FROM docker.io/library/ubuntu@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
...
#4 DONE 5.6s

#5 [2/2] RUN echo 1
#5 0.078 1
#5 DONE 0.2s
```

### env details

```shell
$ ./ssh
root@buildkit-0-9-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.9.0 c8bb937807d405d92be91f06ce2629e6202ac7a9
root@buildkit-0-9-0:~# runc --version
runc version 1.0.0
commit: v1.0.0-0-g84113eef6fc2
spec: 1.0.2-dev
go: go1.16.4
libseccomp: 2.5.1
root@buildkit-0-9-0:~# systemctl status
● buildkit-0-9-0
    State: running
    Units: 307 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Tue 2025-08-26 13:16:56 UTC; 2min 16s ago
  systemd: 255.4-1ubuntu8.10
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─buildkit.service
           │ │ └─290 /usr/local/bin/buildkitd --addr fd://
           │ ├─dbus.service
           │ │ └─291 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
           │ ├─ssh.service
           │ │ └─306 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─304 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─305 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-journald.service
           │ │ └─187 /usr/lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─295 /usr/lib/systemd/systemd-logind
           │ ├─systemd-networkd.service
           │ │ └─274 /usr/lib/systemd/systemd-networkd
           │ ├─systemd-resolved.service
           │ │ └─255 /usr/lib/systemd/systemd-resolved
           │ ├─systemd-timesyncd.service
           │ │ └─256 /usr/lib/systemd/systemd-timesyncd
           │ └─systemd-udevd.service
           │   └─udev
           │     └─248 /usr/lib/systemd/systemd-udevd
           └─user.slice
             └─user-0.slice
               ├─session-1.scope
               │ ├─337 "sshd: root@pts/0"
               │ ├─360 -bash
               │ ├─626 systemctl status
               │ └─627 pager
               └─user@0.service
                 └─init.scope
                   ├─342 /usr/lib/systemd/systemd --user
                   └─343 "(sd-pam)"
```

## build

```shell
make all DIR=buildkit/v0.9.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.9.0_v0.1.0
```
