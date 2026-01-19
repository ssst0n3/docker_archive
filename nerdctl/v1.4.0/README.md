# nerdctl v1.4.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.4.0 -> ssst0n3/docker_archive:nerdctl-v1.4.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.4.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.4.0 -> ssst0n3/docker_archive:ctr_nerdctl-v1.4.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.4.0_v0.1.0

## usage

```shell
$ cd nerdctl/v1.4.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-4-0:~# nerdctl run hello-world

Hello from Docker!
...
root@nerdctl-1-4-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-4-0:~# nerdctl build -t foo .
root@nerdctl-1-4-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED               PLATFORM       SIZE        BLOB SIZE
foo            latest    c22ad2d84bca    30 seconds ago        linux/amd64    16.0 KiB    3.6 KiB
hello-world    latest    05813aedc15f    About a minute ago    linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    About a minute ago    linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-1-4-0:~# nerdctl --version
nerdctl version 1.4.0
root@nerdctl-1-4-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.11.6 2951a28cd7085eb18979b1f710678623d94ed578
root@nerdctl-1-4-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.1 1677a17964311325ed1c31e2c0a3589ce6d5c30d
root@nerdctl-1-4-0:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.4.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.4.0_v0.1.0
```
