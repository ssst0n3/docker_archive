# buildkit v0.21.0-rc1

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.21.0-rc1 -> ssst0n3/docker_archive:buildkit-v0.21.0-rc1_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.21.0-rc1_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.21.0-rc1 -> ssst0n3/docker_archive:ctr_buildkit-v0.21.0-rc1_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.21.0-rc1_v0.1.0

## usage

```shell
$ cd buildkit/v0.21.0-rc1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# cat <<EOF >Dockerfile
FROM busybox
RUN echo 1
EOF
root@localhost:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 61B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/busybox:latest
#2 DONE 30.7s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/2] FROM docker.io/library/busybox:latest@sha256:37f7b378a29ceb4c551b1b5582e27747b855bbfaa73fa11914fe0df028dc581f
#4 resolve docker.io/library/busybox:latest@sha256:37f7b378a29ceb4c551b1b5582e27747b855bbfaa73fa11914fe0df028dc581f done
#4 sha256:97e70d161e81def43e2a371dea30a2ceb2e226e657cac20a243224f21c1bb36f 0B / 2.15MB 0.2s
#4 sha256:97e70d161e81def43e2a371dea30a2ceb2e226e657cac20a243224f21c1bb36f 1.05MB / 2.15MB 1.4s
#4 sha256:97e70d161e81def43e2a371dea30a2ceb2e226e657cac20a243224f21c1bb36f 2.15MB / 2.15MB 2.0s done
#4 extracting sha256:97e70d161e81def43e2a371dea30a2ceb2e226e657cac20a243224f21c1bb36f 0.1s done
#4 DONE 2.1s

#5 [2/2] RUN echo 1
#5 0.093 1
#5 DONE 0.1s
```

```shell
$ ./ssh
root@localhost:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.21.0-rc1 40a5c2d56d8b064f98718f29dd2fd7d5940d7b1c
root@localhost:~# runc --version
runc version 1.2.6
commit: v1.2.6-0-ge89a2992
spec: 1.2.0
go: go1.23.7
libseccomp: 2.5.5
root@localhost:~# systemctl status
● localhost.localdomain
    State: running
    Units: 307 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Tue 2025-05-13 09:39:03 UTC; 2min 43s ago
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
           │ │ └─299 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─system-getty.slice
           │ │ └─getty@tty1.service
           │ │   └─303 /sbin/agetty -o "-p -- \\u" --noclear - linux
           │ ├─system-serial\x2dgetty.slice
           │ │ └─serial-getty@ttyS0.service
           │ │   └─304 /sbin/agetty -o "-p -- \\u" --keep-baud 115200,57600,38400,9600 - vt220
           │ ├─systemd-journald.service
           │ │ └─188 /usr/lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─293 /usr/lib/systemd/systemd-logind
           │ ├─systemd-networkd.service
           │ │ └─273 /usr/lib/systemd/systemd-networkd
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
               │ ├─341 "sshd: root@pts/0"
               │ ├─364 -bash
               │ ├─478 systemctl status
               │ └─479 pager
               └─user@0.service
                 └─init.scope
                   ├─346 /usr/lib/systemd/systemd --user
                   └─347 "(sd-pam)"
```

## build

```shell
make all DIR=buildkit/v0.21.0-rc1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.21.0-rc1_v0.1.0
```
