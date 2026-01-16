# nerdctl v1.7.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.7.0 -> ssst0n3/docker_archive:nerdctl-v1.7.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.7.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.7.0 -> ssst0n3/docker_archive:ctr_nerdctl-v1.7.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.7.0_v0.1.0

## usage

```shell
$ cd nerdctl/v1.7.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-7-0:~# nerdctl run hello-world

Hello from Docker!
...
root@nerdctl-1-7-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-7-0:~# nerdctl build -t foo .
root@nerdctl-1-7-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE        BLOB SIZE
foo            latest    755475cef9f0    5 seconds ago     linux/amd64    16.0 KiB    3.4 KiB
hello-world    latest    05813aedc15f    42 seconds ago    linux/amd64    16.0 KiB    15.9 KiB
```

```shell
$ ./ssh
root@nerdctl-1-7-0:~# nerdctl --version
nerdctl version 1.7.0
root@nerdctl-1-7-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.12.3 438f47256f0decd64cc96084e22d3357da494c27
root@nerdctl-1-7-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.8 8e4b0bde866788eec76735cc77c4720144248fb7
root@nerdctl-1-7-0:~# runc --version
runc version 1.1.9
commit: v1.1.9-0-gccaecfcb
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.7.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.7.0_v0.1.0
```
