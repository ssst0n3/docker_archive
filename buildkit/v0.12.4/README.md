# buildkit v0.12.4

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.12.4 -> ssst0n3/docker_archive:buildkit-v0.12.4_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.12.4_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.4 -> ssst0n3/docker_archive:ctr_buildkit-v0.12.4_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.4_v0.1.0

## usage

```shell
$ cd buildkit/v0.12.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@buildkit-0-12-4:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-12-4:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 60B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/ubuntu:latest
#2 DONE 6.7s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
...
#4 DONE 12.4s

#5 [2/2] RUN echo 1
#5 0.087 1
#5 DONE 0.2s
```

```shell
$ ./ssh
root@buildkit-0-12-4:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.4 833949d0f7908608b00ab6b93b8f92bdb147fcca
root@buildkit-0-12-4:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@buildkit-0-12-4:~# systemctl status
● buildkit-0-12-4
    State: running
    Units: 307 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Tue 2025-08-26 02:34:54 UTC; 4min 51s ago
  systemd: 255.4-1ubuntu8.10
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─buildkit.service
           │ │ └─291 /usr/local/bin/buildkitd --addr fd://
           │ ├─dbus.service
           │ │ └─292 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
           │ ├─ssh.service
           │ │ └─305 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─297 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─298 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-journald.service
           │ │ └─187 /usr/lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─295 /usr/lib/systemd/systemd-logind
           │ ├─systemd-networkd.service
           │ │ └─262 /usr/lib/systemd/systemd-networkd
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
               │ ├─338 "sshd: root@pts/0"
               │ ├─361 -bash
               │ ├─466 systemctl status
               │ └─467 pager
               └─user@0.service
                 └─init.scope
                   ├─343 /usr/lib/systemd/systemd --user
                   └─344 "(sd-pam)"
```

## build

```shell
make all DIR=buildkit/v0.12.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.12.4_v0.1.0
```
