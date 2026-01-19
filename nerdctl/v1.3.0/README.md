# nerdctl v1.3.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.3.0 -> ssst0n3/docker_archive:nerdctl-v1.3.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.3.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.3.0 -> ssst0n3/docker_archive:ctr_nerdctl-v1.3.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.3.0_v0.1.0

## usage

```shell
$ cd nerdctl/v1.3.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-3-0:~# nerdctl run hello-world

Hello from Docker!
...
root@nerdctl-1-3-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-3-0:~# nerdctl build -t foo .
root@nerdctl-1-3-0:~# nerdctl images
WARN[0000] failed to get unpacked size of image "docker.io/library/hello-world:latest" for platform "linux/386"  error="snapshot sha256:17e231846bbb64aa6c24a6a24c29757104fb52758c83a39e8bd395d9e8a35977 does not exist: not found"
REPOSITORY     TAG       IMAGE ID        CREATED               PLATFORM       SIZE        BLOB SIZE
foo            latest    c22ad2d84bca    39 seconds ago        linux/amd64    16.0 KiB    3.6 KiB
hello-world    latest    05813aedc15f    About a minute ago    linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    About a minute ago    linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-1-3-0:~# nerdctl --version
nerdctl version 1.3.0
root@nerdctl-1-3-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.11.5 252ae63bcf2a9b62777add4838df5a257b86e991
root@nerdctl-1-3-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.0 1fbd70374134b891f97ce19c70b6e50c7b9f4e0d
root@nerdctl-1-3-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.3.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.3.0_v0.1.0
```
