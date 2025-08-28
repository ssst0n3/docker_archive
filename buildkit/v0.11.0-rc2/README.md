# buildkit v0.11.0-rc2

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.11.0-rc2 -> ssst0n3/docker_archive:buildkit-v0.11.0-rc2_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.11.0-rc2_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.11.0-rc2 -> ssst0n3/docker_archive:ctr_buildkit-v0.11.0-rc2_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.11.0-rc2_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.11.0-rc2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-11-0-rc2:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-11-0-rc2:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 60B done
#1 DONE 0.1s

#2 [internal] load .dockerignore
#2 transferring context: 2B done
#2 DONE 0.1s

#3 [internal] load metadata for docker.io/library/ubuntu:latest
#3 DONE 7.5s

#4 [1/2] FROM docker.io/library/ubuntu@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
...
#4 DONE 10.3s

#5 [2/2] RUN echo 1
#0 0.086 1
#5 DONE 0.2s
```

### env details

```shell
$ ./ssh
root@buildkit-0-11-0-rc2:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.11.0-rc2 a489366c7c793b96817994fa4c8195f2cbecd64a
root@buildkit-0-11-0-rc2:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@buildkit-0-11-0-rc2:~# systemctl status buildkit
● buildkit.service - BuildKit
     Loaded: loaded (/usr/local/lib/systemd/system/buildkit.service; enabled; preset: enabled)
     Active: active (running) since Thu 2025-08-28 02:33:36 UTC; 1min 49s ago
TriggeredBy: ● buildkit.socket
       Docs: https://github.com/moby/buildkit
   Main PID: 291 (buildkitd)
      Tasks: 8 (limit: 2329)
     Memory: 176.3M (peak: 178.9M)
        CPU: 1.093s
     CGroup: /system.slice/buildkit.service
             └─291 /usr/local/bin/buildkitd --addr fd://

Aug 28 02:33:36 buildkit-0-11-0-rc2 systemd[1]: Starting buildkit.service - BuildKit...
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=info msg="auto snapshotter: using overlayfs"
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=warning msg="using host network as the default"
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=warning msg="git source cannot be enabled: failed to find git binary: exec: \"git\": executable file not found in $PATH"
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=info msg="found worker \"u7672ghzqo6fxloux7fifv8uq\", labels=map[org.mobyproject.buildkit.worker.executor:oci org.mobyproject.buildkit.worker.hostname:b
uildkit-0-11-0-rc2 org.mobyproject.buildkit.worker.network:host org.mobyproject.buildkit.worker.oci.process-mode:sandbox org.mobyproject.buildkit.worker.selinux.enabled:false org.mobyproject.buildkit.worker.snapshotter:overlayfs], platfor
ms=[linux/amd64 linux/386]"
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=warning msg="skipping containerd worker, as \"/run/containerd/containerd.sock\" does not exist"
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=info msg="found 1 workers, default=\"u7672ghzqo6fxloux7fifv8uq\""
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=warning msg="currently, only the default worker can be used."
Aug 28 02:33:36 buildkit-0-11-0-rc2 systemd[1]: Started buildkit.service - BuildKit.
Aug 28 02:33:36 buildkit-0-11-0-rc2 buildkitd[291]: time="2025-08-28T02:33:36Z" level=info msg="running server on /run/buildkit/buildkitd.sock"
```

## build

```shell
make all DIR=buildkit/v0.11.0-rc2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.11.0-rc2_v0.1.0
```
