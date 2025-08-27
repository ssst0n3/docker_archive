# buildkit v0.5.0

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.5.0 -> ssst0n3/docker_archive:buildkit-v0.5.0_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.5.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.5.0 -> ssst0n3/docker_archive:ctr_buildkit-v0.5.0_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.5.0_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.5.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-5-0:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-5-0:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#2 [internal] load build definition from Dockerfile
#2 transferring dockerfile: 60B done
#2 DONE 0.0s

#1 [internal] load .dockerignore
#1 transferring context: 2B done
#1 DONE 0.0s

#3 [internal] load metadata for docker.io/library/ubuntu:latest
#3 DONE 5.8s

#5 [1/2] FROM docker.io/library/ubuntu@sha256:7c06e91f61fa88c08cc74f7e1b7c6...
...
#5 DONE 6.1s

#4 [2/2] RUN echo 1
#4 0.101 1
#4 DONE 0.7s
```

### env details

```shell
$ ./ssh
root@buildkit-0-5-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.5.0 8c0fa8fdec187d8f259a349d2da16dc2dc5f144a
root@buildkit-0-5-0:~# runc --version
runc version 1.0.0-rc7
spec: 1.0.1-dev
root@buildkit-0-5-0:~# systemctl status buildkit
● buildkit.service - BuildKit
     Loaded: loaded (/usr/local/lib/systemd/system/buildkit.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2025-08-27 02:05:05 UTC; 2min 45s ago
TriggeredBy: ● buildkit.socket
       Docs: https://github.com/moby/buildkit
   Main PID: 272 (buildkitd)
      Tasks: 10 (limit: 2335)
     Memory: 163.9M
     CGroup: /system.slice/buildkit.service
             └─272 /usr/local/bin/buildkitd

Aug 27 02:05:05 buildkit-0-5-0 systemd[1]: Started BuildKit.
Aug 27 02:05:06 buildkit-0-5-0 buildkitd[272]: time="2025-08-27T02:05:06Z" level=warning msg="git source cannot be enabled: failed to find git binary: exec: \"git\": executable file not found in $PATH"
Aug 27 02:05:06 buildkit-0-5-0 buildkitd[272]: time="2025-08-27T02:05:06Z" level=info msg="found worker \"yaynxlskp2j17ebtnvkbzxqyv\", labels=map[org.mobyproject.buildkit.worker.executor:oci org.mobyproject.buildkit.worker.hostname:buildk
it-0-5-0 org.mobyproject.buildkit.worker.snapshotter:overlayfs], platforms=[linux/amd64]"
Aug 27 02:05:06 buildkit-0-5-0 buildkitd[272]: time="2025-08-27T02:05:06Z" level=warning msg="skipping containerd worker, as \"/run/containerd/containerd.sock\" does not exist"
Aug 27 02:05:06 buildkit-0-5-0 buildkitd[272]: time="2025-08-27T02:05:06Z" level=info msg="found 1 workers, default=\"yaynxlskp2j17ebtnvkbzxqyv\""
Aug 27 02:05:06 buildkit-0-5-0 buildkitd[272]: time="2025-08-27T02:05:06Z" level=warning msg="currently, only the default worker can be used."
Aug 27 02:05:06 buildkit-0-5-0 buildkitd[272]: time="2025-08-27T02:05:06Z" level=info msg="running server on /run/buildkit/buildkitd.sock"
```

## build

```shell
make all DIR=buildkit/v0.5.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.5.0_v0.1.0
```
