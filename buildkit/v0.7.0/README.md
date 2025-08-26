# buildkit v0.7.0

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.7.0 -> ssst0n3/docker_archive:buildkit-v0.7.0_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.7.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.7.0 -> ssst0n3/docker_archive:ctr_buildkit-v0.7.0_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.7.0_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.7.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-7-0:~# cat <<EOF >Dockerfile
> FROM ubuntu
> RUN echo 1
> EOF
root@buildkit-0-7-0:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#2 [internal] load .dockerignore
#2 transferring context: 2B done
#2 DONE 0.1s

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 60B done
#1 DONE 0.1s

#3 [internal] load metadata for docker.io/library/ubuntu:latest
#3 DONE 6.1s

#4 [1/2] FROM docker.io/library/ubuntu@sha256:7c06e91f61fa88c08cc74f7e1b7c6...
...
#4 DONE 7.3s

#5 [2/2] RUN echo 1
#5 0.101 1
#5 DONE 0.5s
```

### env details

```shell
$ ./ssh
root@buildkit-0-7-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.7.0 c60a1eb215d795a12e43ceff6a5ed67ce1ad958d
root@buildkit-0-7-0:~# runc --version
runc version 1.0.0-rc10
spec: 1.0.1-dev
root@buildkit-0-7-0:~# systemctl status buildkit
● buildkit.service - BuildKit
     Loaded: loaded (/usr/local/lib/systemd/system/buildkit.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2025-08-26 14:41:03 UTC; 1min 19s ago
TriggeredBy: ● buildkit.socket
       Docs: https://github.com/moby/buildkit
   Main PID: 272 (buildkitd)
      Tasks: 11 (limit: 2335)
     Memory: 167.8M
     CGroup: /system.slice/buildkit.service
             └─272 /usr/local/bin/buildkitd

Aug 26 14:41:03 buildkit-0-7-0 systemd[1]: Started BuildKit.
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=info msg="auto snapshotter: using overlayfs"
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=warning msg="using host network as the default"
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=warning msg="git source cannot be enabled: failed to find git binary: exec: \"git\": executable file not found in $PATH"
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=info msg="found worker \"2caabtxyysptzqxk08omcodbf\", labels=map[org.mobyproject.buildkit.worker.executor:oci org.mobyproject.buildkit.worker.hostname:buildk
it-0-7-0 org.mobyproject.buildkit.worker.snapshotter:overlayfs], platforms=[linux/amd64 linux/386]"
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=warning msg="skipping containerd worker, as \"/run/containerd/containerd.sock\" does not exist"
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=info msg="found 1 workers, default=\"2caabtxyysptzqxk08omcodbf\""
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=warning msg="currently, only the default worker can be used."
Aug 26 14:41:04 buildkit-0-7-0 buildkitd[272]: time="2025-08-26T14:41:04Z" level=info msg="running server on /run/buildkit/buildkitd.sock"
```

## build

```shell
make all DIR=buildkit/v0.7.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.7.0_v0.1.0
```
