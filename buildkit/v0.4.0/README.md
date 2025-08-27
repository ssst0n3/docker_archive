# buildkit v0.4.0

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.4.0 -> ssst0n3/docker_archive:buildkit-v0.4.0_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.4.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.4.0 -> ssst0n3/docker_archive:ctr_buildkit-v0.4.0_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.4.0_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.4.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-4-0:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-4-0:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#2 [internal] load build definition from Dockerfile
...
#1 [internal] load .dockerignore
...
#3 [internal] load metadata for docker.io/library/ubuntu:latest
...
#4 [1/2] FROM docker.io/library/ubuntu@sha256:7c06e91f61fa88c08cc74f7e1b7c6...
...
#5 [2/2] RUN echo 1
#5       digest: sha256:265d26eb0a10e3a0a557654111c79cc849c0a4647d94f7e35e22a24ac17a0301
#5         name: "[2/2] RUN echo 1"
#5      started: 2025-08-27 02:22:01.935091995 +0000 UTC
#5 0.096 1
#5    completed: 2025-08-27 02:22:02.369364857 +0000 UTC
#5     duration: 434.272862ms
```

### env details

```shell
$ ./ssh
root@buildkit-0-4-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.4.0 c35410878ab9070498c66f6c67d3e8bc3b92241f
root@buildkit-0-4-0:~# runc --version
runc version 1.0.0-rc7
spec: 1.0.1-dev
root@buildkit-0-4-0:~# systemctl status buildkit
● buildkit.service - BuildKit
     Loaded: loaded (/usr/local/lib/systemd/system/buildkit.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2025-08-27 02:21:03 UTC; 2min 12s ago
TriggeredBy: ● buildkit.socket
       Docs: https://github.com/moby/buildkit
   Main PID: 272 (buildkitd)
      Tasks: 10 (limit: 2335)
     Memory: 163.0M
     CGroup: /system.slice/buildkit.service
             └─272 /usr/local/bin/buildkitd

Aug 27 02:21:03 buildkit-0-4-0 systemd[1]: Started BuildKit.
Aug 27 02:21:04 buildkit-0-4-0 buildkitd[272]: time="2025-08-27T02:21:04Z" level=warning msg="git source cannot be enabled: failed to find git binary: exec: \"git\": executable file not found in $PATH"
Aug 27 02:21:04 buildkit-0-4-0 buildkitd[272]: time="2025-08-27T02:21:04Z" level=info msg="found worker \"op3x6okojmvz6qmnaoozn699f\", labels=map[org.mobyproject.buildkit.worker.hostname:buildkit-0-4-0 org.mobyproject.buildkit.worker.exec
utor:oci org.mobyproject.buildkit.worker.snapshotter:overlayfs], platforms=[linux/amd64]"
Aug 27 02:21:04 buildkit-0-4-0 buildkitd[272]: time="2025-08-27T02:21:04Z" level=warning msg="skipping containerd worker, as \"/run/containerd/containerd.sock\" does not exist"
Aug 27 02:21:04 buildkit-0-4-0 buildkitd[272]: time="2025-08-27T02:21:04Z" level=info msg="found 1 workers, default=\"op3x6okojmvz6qmnaoozn699f\""
Aug 27 02:21:04 buildkit-0-4-0 buildkitd[272]: time="2025-08-27T02:21:04Z" level=warning msg="currently, only the default worker can be used."
Aug 27 02:21:04 buildkit-0-4-0 buildkitd[272]: time="2025-08-27T02:21:04Z" level=info msg="running server on /run/buildkit/buildkitd.sock"
```

## build

```shell
make all DIR=buildkit/v0.4.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.4.0_v0.1.0
```
