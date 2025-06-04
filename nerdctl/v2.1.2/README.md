# nerdctl v2.1.2

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v2.1.2 -> ssst0n3/docker_archive:nerdctl-v2.1.2_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v2.1.2_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v2.1.2 -> ssst0n3/docker_archive:ctr_nerdctl-v2.1.2_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v2.1.2_v0.1.0

## usage

```shell
$ cd nerdctl/v2.1.2
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
nerdctl version 2.1.2
root@localhost:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.21.1 66735c67040bc80e6ed104f451683e094030a4e1
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.1 cb1076646aa3740577fafbf3d914198b7fe8e3f7
root@localhost:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
```

## build

```shell
make all DIR=nerdctl/v2.1.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v2.1.2_v0.1.0
```
