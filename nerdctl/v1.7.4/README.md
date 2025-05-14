# nerdctl v1.7.4

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.7.4 -> ssst0n3/docker_archive:nerdctl-v1.7.4_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.7.4_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.7.4 -> ssst0n3/docker_archive:ctr_nerdctl-v1.7.4_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.7.4_v0.1.0

## usage

```shell
$ cd nerdctl/v1.7.4
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
nerdctl version 1.7.4
root@localhost:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.5 bac3f2b673f3f9d33e79046008e7a38e856b3dc6
root@localhost:~# containerd --version
containerd github.com/containerd/containerd v1.7.13 7c3aca7a610df76212171d200ca3811ff6096eb8
root@localhost:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.7.4
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.7.4_v0.1.0
```
