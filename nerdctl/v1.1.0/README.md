# nerdctl v1.1.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.1.0 -> ssst0n3/docker_archive:nerdctl-v1.1.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.1.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.1.0 -> ssst0n3/docker_archive:ctr_nerdctl-v1.1.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.1.0_v0.1.0

## usage

```shell
$ cd nerdctl/v1.1.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-1-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser) 
root@nerdctl-1-1-0:~# nerdctl run hello-world

Hello from Docker!
...
root@nerdctl-1-1-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-1-0:~# nerdctl build -t foo .
root@nerdctl-1-1-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED                   PLATFORM       SIZE        BLOB SIZE
foo            latest    1dc69bc2653d    Less than a second ago    linux/amd64    16.0 KiB    3.7 KiB
hello-world    latest    05813aedc15f    41 seconds ago            linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    41 seconds ago            linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-1-1-0:~# nerdctl --version
nerdctl version 1.1.0
root@nerdctl-1-1-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.10.6 0c9b5aeb269c740650786ba77d882b0259415ec7
root@nerdctl-1-1-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.12 a05d175400b1145e5e6a735a6710579d181e7fb0
root@nerdctl-1-1-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.1.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.1.0_v0.1.0
```

## Known Issue

### apparmor_parser

https://github.com/containerd/nerdctl/issues/3945

```
root@nerdctl-1-1-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
```