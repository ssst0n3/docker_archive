# nerdctl v2.0.4

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v2.0.4 -> ssst0n3/docker_archive:nerdctl-v2.0.4_v0.2.0
    * ssst0n3/docker_archive:nerdctl-v2.0.4_v0.2.0
    * ssst0n3/docker_archive:nerdctl-v2.0.4_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v2.0.4 -> ssst0n3/docker_archive:ctr_nerdctl-v2.0.4_v0.2.0
    * ssst0n3/docker_archive:ctr_nerdctl-v2.0.4_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_nerdctl-v2.0.4_v0.1.0

## usage

```shell
$ cd nerdctl/v2.0.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# nerdctl run hello-world

Hello from Docker!
...
root@localhost:~# echo 'FROM hello-world' > Dockerfile
root@localhost:~# nerdctl build -t foo .
root@localhost:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED               PLATFORM       SIZE       BLOB SIZE
foo            latest    a3cc1607cd6e    37 seconds ago        linux/amd64    16.38kB    3.482kB
hello-world    latest    7e1a4e2d11e2    About a minute ago    linux/amd64    16.38kB    4.018kB
```

```shell
$ ./ssh
root@localhost:~# nerdctl --version
nerdctl version 2.0.4
root@localhost:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.20.2 97437fdd7e32f29bb80288d800cd4ffcb34e1c15
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.4 1a43cb6a1035441f9aca8f5666a9b3ef9e70ab20
root@localhost:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
```

## build

```shell
make all DIR=nerdctl/v2.0.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v2.0.4_v0.2.0
```
