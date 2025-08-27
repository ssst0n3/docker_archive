# buildkit v0.12.0

* dqd: 
    * ssst0n3/docker_archive:buildkit-v0.12.0 -> ssst0n3/docker_archive:buildkit-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:buildkit-v0.12.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.0 -> ssst0n3/docker_archive:ctr_buildkit-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:ctr_buildkit-v0.12.0_v0.1.0

## how-to-use

```shell
$ cd buildkit/v0.12.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@buildkit-0-12-0:~# cat <<EOF >Dockerfile
FROM ubuntu
RUN echo 1
EOF
root@buildkit-0-12-0:~# buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. --progress=plain
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 60B done
#1 DONE 0.2s

#2 [internal] load metadata for docker.io/library/ubuntu:latest
#2 DONE 7.3s

#3 [internal] load .dockerignore
#3 transferring context:
#3 transferring context: 2B done
#3 DONE 0.1s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
#4 resolve docker.io/library/ubuntu:latest@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9 0.1s done
#4 DONE 0.1s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
#4 DONE 0.2s

#4 [1/2] FROM docker.io/library/ubuntu:latest@sha256:7c06e91f61fa88c08cc74f7e1b7c69ae24910d745357e0dfe1d2c0322aaf20f9
...
#4 DONE 13.1s

#5 [2/2] RUN echo 1
#5 0.141 1
#5 DONE 0.4s
```

### env details

```shell
$ ./ssh
root@buildkit-0-12-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.0 18fc875d9bfd6e065cd8211abc639434ba65aa56
root@buildkit-0-12-0:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@buildkit-0-12-0:~# systemctl status buildkit
● buildkit.service - BuildKit
     Loaded: loaded (/usr/local/lib/systemd/system/buildkit.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-08-27 14:03:16 UTC; 1min 6s ago
TriggeredBy: ● buildkit.socket
       Docs: https://github.com/moby/buildkit
   Main PID: 289 (buildkitd)
      Tasks: 10 (limit: 2329)
     Memory: 178.1M (peak: 182.1M)
        CPU: 1.142s
     CGroup: /system.slice/buildkit.service
             └─289 /usr/local/bin/buildkitd --addr fd://

Aug 27 14:03:15 buildkit-0-12-0 systemd[1]: Starting buildkit.service - BuildKit...
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=info msg="auto snapshotter: using overlayfs"
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=warning msg="using host network as the default"
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=warning msg="git source cannot be enabled: failed to find git binary: exec: \"git\": executable file not found in $PATH"
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=info msg="found worker \"ppj76st2yjmf16uteoqytge0v\", labels=map[org.mobyproject.buildkit.worker.executor:oci org.mobyproject.buildkit.worker.hostname:build
kit-0-12-0 org.mobyproject.buildkit.worker.network:host org.mobyproject.buildkit.worker.oci.process-mode:sandbox org.mobyproject.buildkit.worker.selinux.enabled:false org.mobyproject.buildkit.worker.snapshotter:overlayfs], platforms=[linu
x/amd64 linux/386]"
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=warning msg="skipping containerd worker, as \"/run/containerd/containerd.sock\" does not exist"
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=info msg="found 1 workers, default=\"ppj76st2yjmf16uteoqytge0v\""
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=warning msg="currently, only the default worker can be used."
Aug 27 14:03:16 buildkit-0-12-0 systemd[1]: Started buildkit.service - BuildKit.
Aug 27 14:03:16 buildkit-0-12-0 buildkitd[289]: time="2025-08-27T14:03:16Z" level=info msg="running server on /run/buildkit/buildkitd.sock"
```

## build

```shell
make all DIR=buildkit/v0.12.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_buildkit-v0.12.0_v0.1.0
```
