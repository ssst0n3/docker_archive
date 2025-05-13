# buildkit v0.20.2

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.20.2 -> ssst0n3/docker_archive:buildkit-v0.20.2_v0.2.0
    * ssst0n3/docker_archive:buildkit-v0.20.2_v0.2.0
    * ssst0n3/docker_archive:buildkit-v0.20.2_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.20.2 -> ssst0n3/docker_archive:ctr_buildkit-v0.20.2_v0.2.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.20.2_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_buildkit-v0.20.2_v0.1.0

## usage

```shell
$ cd buildkit/v0.20.2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@localhost:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 60B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/ubuntu:latest
#2 DONE 6.6s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:6015f66923d7afbc53558d7ccffd325d43b4e249f41a6e93eef074c9505d2233
...
#4 DONE 9.5s

#5 [2/2] RUN echo 1
#5 0.091 1
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
    Since: Tue 2025-05-13 09:18:24 UTC; 1min 40s ago
  systemd: 255.4-1ubuntu8.6
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─buildkit.service
           │ │ └─289 /usr/local/bin/buildkitd --addr fd://
           │ ├─dbus.service
           │ │ └─290 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
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
           │ │ └─269 /usr/lib/systemd/systemd-networkd
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
               │ ├─341 "sshd: root@pts/0"
               │ ├─364 -bash
               │ ├─453 systemctl status
               │ └─454 pager
               └─user@0.service
                 └─init.scope
                   ├─346 /usr/lib/systemd/systemd --user
                   └─347 "(sd-pam)"
```

## build

```shell
make all DIR=buildkit/v0.20.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.20.2_v0.2.0
```
