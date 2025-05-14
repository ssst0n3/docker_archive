# nerdctl v2.0.5

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v2.0.5 -> ssst0n3/docker_archive:nerdctl-v2.0.5_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v2.0.5_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v2.0.5 -> ssst0n3/docker_archive:ctr_nerdctl-v2.0.5_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v2.0.5_v0.1.0

## usage

```shell
$ cd nerdctl/v2.0.5
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
nerdctl version 2.0.5
root@localhost:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.21.1 66735c67040bc80e6ed104f451683e094030a4e1
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.5 fb4c30d4ede3531652d86197bf3fc9515e5276d9
root@localhost:~# runc --version
runc version 1.2.6
commit: v1.2.6-0-ge89a2992
spec: 1.2.0
go: go1.23.7
libseccomp: 2.5.5
```

## build

```shell
make all DIR=nerdctl/v2.0.5
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v2.0.5_v0.1.0
```
