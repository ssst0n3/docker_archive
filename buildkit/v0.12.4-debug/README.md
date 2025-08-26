# buildkit v0.12.4 debug

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.12.4-debug -> ssst0n3/docker_archive:buildkit-v0.12.4-debug_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.12.4-debug_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.4-debug -> ssst0n3/docker_archive:ctr_buildkit-v0.12.4-debug_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.4-debug_v0.1.0

## quick-start

```shell
$ cd buildkit/v0.12.4-debug
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### debug

```shell
root@buildkit-0-12-4-debug:~# systemctl stop buildkit
Stopping 'buildkit.service', but its triggering units are still active:
buildkit.socket
root@buildkit-0-12-4-debug:~# ln -sf /usr/local/bin/debug.sh /usr/local/bin/buildkitd 
root@buildkit-0-12-4-debug:~# buildkitd 
API server listening at: [::]:2345
2025-08-26T03:02:50Z warning layer=rpc Listening for remote connections (connections are not authenticated nor encrypted)
```

### usage

```shell
$ ./ssh
root@buildkit-0-12-4-debug:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-12-4-debug:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 60B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/ubuntu:latest
#2 DONE 7.0s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
...
#4 DONE 10.5s

#5 [2/2] RUN echo 1
#5 0.074 1
#5 DONE 0.2s
```

### env details

```shell
$ ./ssh
root@buildkit-0-12-4-debug:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.4 833949d0f7908608b00ab6b93b8f92bdb147fcca
root@buildkit-0-12-4-debug:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@buildkit-0-12-4-debug:~# systemctl status
● buildkit-0-12-4-debug
    State: running
    Units: 307 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Tue 2025-08-26 02:58:05 UTC; 3min 53s ago
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
           │ │ └─303 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─309 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─310 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-journald.service
           │ │ └─187 /usr/lib/systemd/systemd-journald
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
               │ ├─342 "sshd: root@pts/0"
               │ ├─365 -bash
               │ ├─446 systemctl status
               │ └─447 pager
               └─user@0.service
                 └─init.scope
                   ├─347 /usr/lib/systemd/systemd --user
                   └─348 "(sd-pam)"
```

## build

```shell
make all DIR=buildkit/v0.12.4-debug
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.12.4-debug_v0.1.0
```
