# nerdctl v1.7.3

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.7.3 -> ssst0n3/docker_archive:nerdctl-v1.7.3_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.7.3_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.7.3 -> ssst0n3/docker_archive:ctr_nerdctl-v1.7.3_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.7.3_v0.1.0

## usage

```shell
$ cd nerdctl/v1.7.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-7-3:~# nerdctl run hello-world

Hello from Docker!
...
root@nerdctl-1-7-3:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-7-3:~# nerdctl build -t foo .
root@nerdctl-1-7-3:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED          PLATFORM       SIZE        BLOB SIZE
foo            latest    755475cef9f0    2 minutes ago    linux/amd64    16.0 KiB    3.4 KiB
hello-world    latest    05813aedc15f    2 minutes ago    linux/amd64    16.0 KiB    15.9 KiB
```

```shell
$ ./ssh
root@nerdctl-1-7-3:~# nerdctl --version
nerdctl version 1.7.3
root@nerdctl-1-7-3:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.5 bac3f2b673f3f9d33e79046008e7a38e856b3dc6
root@nerdctl-1-7-3:~# containerd --version
containerd github.com/containerd/containerd v1.7.13 7c3aca7a610df76212171d200ca3811ff6096eb8
root@nerdctl-1-7-3:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.7.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.7.3_v0.1.0
```
