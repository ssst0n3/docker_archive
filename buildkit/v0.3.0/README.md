# buildkit v0.3.0

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.3.0 -> ssst0n3/docker_archive:buildkit-v0.3.0_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.3.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.3.0 -> ssst0n3/docker_archive:ctr_buildkit-v0.3.0_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.3.0_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.3.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-3-0:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-3-0:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#2 [internal] load build definition from Dockerfile
...
#1 [internal] load .dockerignore
...
#3 [internal] load metadata for docker.io/library/ubuntu:latest
...
#5 [1/2] FROM docker.io/library/ubuntu@sha256:7c06e91f61fa88c08cc74f7e1b7c6...
...
#4 [2/2] RUN echo 1
#4       digest: sha256:265d26eb0a10e3a0a557654111c79cc849c0a4647d94f7e35e22a24ac17a0301
#4         name: "[2/2] RUN echo 1"
#4      started: 2025-08-27 02:48:14.586820374 +0000 UTC
#4 0.048 1
#4    completed: 2025-08-27 02:48:14.808276591 +0000 UTC
#4     duration: 221.456217ms
```

### env details

```shell
$ ./ssh
root@buildkit-0-3-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.3.0 663f185a07b532664020d616b0e55873c2741307
root@buildkit-0-3-0:~# runc --version
runc version 1.0.0-rc6
spec: 1.0.1-dev
root@buildkit-0-3-0:~# systemctl status buildkit
● buildkit.service - BuildKit
     Loaded: loaded (/usr/local/lib/systemd/system/buildkit.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2025-08-27 02:46:01 UTC; 3min 3s ago
TriggeredBy: ● buildkit.socket
       Docs: https://github.com/moby/buildkit
   Main PID: 271 (buildkitd)
      Tasks: 10 (limit: 2335)
     Memory: 165.3M
     CGroup: /system.slice/buildkit.service
             └─271 /usr/local/bin/buildkitd

Aug 27 02:46:01 buildkit-0-3-0 systemd[1]: Started BuildKit.
Aug 27 02:46:02 buildkit-0-3-0 buildkitd[271]: time="2025-08-27T02:46:02Z" level=info msg="found worker "9t89pzcwlt9f90dvsa3tjp93g", labels=map[org.mobyproject.buildkit.worker.executor:oci org.mobyproject.buildkit.worker.snapshotter:over>
Aug 27 02:46:02 buildkit-0-3-0 buildkitd[271]: time="2025-08-27T02:46:02Z" level=warning msg="skipping containerd worker, as "/run/containerd/containerd.sock" does not exist"
Aug 27 02:46:02 buildkit-0-3-0 buildkitd[271]: time="2025-08-27T02:46:02Z" level=info msg="found 1 workers, default="9t89pzcwlt9f90dvsa3tjp93g""
Aug 27 02:46:02 buildkit-0-3-0 buildkitd[271]: time="2025-08-27T02:46:02Z" level=warning msg="currently, only the default worker can be used."
Aug 27 02:46:02 buildkit-0-3-0 buildkitd[271]: time="2025-08-27T02:46:02Z" level=info msg="running server on /run/buildkit/buildkitd.sock"
```

## build

```shell
make all DIR=buildkit/v0.3.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.3.0_v0.1.0
```
