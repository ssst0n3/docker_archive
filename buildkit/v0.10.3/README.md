# buildkit v0.10.3

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.10.3 -> ssst0n3/docker_archive:buildkit-v0.10.3_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.10.3_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.10.3 -> ssst0n3/docker_archive:ctr_buildkit-v0.10.3_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.10.3_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.10.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-10-3:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-10-3:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load .dockerignore
#1 transferring context: 2B done
#1 DONE 0.1s

#2 [internal] load build definition from Dockerfile
#2 transferring dockerfile: 60B done
#2 DONE 0.1s

#3 [internal] load metadata for docker.io/library/ubuntu:latest
#3 DONE 2.3s

#4 [1/2] FROM docker.io/library/ubuntu@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
...
#4 DONE 12.0s

#5 [2/2] RUN echo 1
#5 0.132 1
#5 DONE 0.4s
```

### env details

```shell
$ ./ssh
root@buildkit-0-10-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.10.0 068cf686a7e5c3254244d0acc54636f4f393611e
root@buildkit-0-10-0:~# runc --version
runc version 1.0.2
commit: v1.0.2-0-g52b36a2dd837
spec: 1.0.2-dev
go: go1.16.7
libseccomp: 2.5.1
root@buildkit-0-10-3:~# systemctl status buildkit
● buildkit.service - BuildKit
     Loaded: loaded (/usr/local/lib/systemd/system/buildkit.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-08-27 14:49:59 UTC; 3min 3s ago
TriggeredBy: ● buildkit.socket
       Docs: https://github.com/moby/buildkit
   Main PID: 291 (buildkitd)
      Tasks: 8 (limit: 2329)
     Memory: 180.1M (peak: 184.1M)
        CPU: 1.142s
     CGroup: /system.slice/buildkit.service
             └─291 /usr/local/bin/buildkitd --addr fd://
...
```

## build

```shell
make all DIR=buildkit/v0.10.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.10.3_v0.1.0
```
