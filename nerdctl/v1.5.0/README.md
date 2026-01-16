# nerdctl v1.5.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.5.0 -> ssst0n3/docker_archive:nerdctl-v1.5.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.5.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.5.0 -> ssst0n3/docker_archive:ctr_nerdctl-v1.5.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.5.0_v0.1.0

## usage

```shell
$ cd nerdctl/v1.5.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-5-0:~# nerdctl run hello-world

Hello from Docker!
...
root@nerdctl-1-5-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-5-0:~# nerdctl build -t foo .
root@nerdctl-1-5-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE        BLOB SIZE
foo            latest    755475cef9f0    1 second ago      linux/amd64    16.0 KiB    3.4 KiB
hello-world    latest    05813aedc15f    18 seconds ago    linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    18 seconds ago    linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-1-5-0:~# nerdctl --version
nerdctl version 1.5.0
root@nerdctl-1-5-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.0 18fc875d9bfd6e065cd8211abc639434ba65aa56
root@nerdctl-1-5-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.3 7880925980b188f4c97b462f709d0db8e8962aff
root@nerdctl-1-5-0:~# runc --version
runc version 1.1.8
commit: v1.1.8-0-g82f18fe0
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.5.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.5.0_v0.1.0
```
