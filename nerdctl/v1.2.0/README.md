# nerdctl v1.2.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.2.0 -> ssst0n3/docker_archive:nerdctl-v1.2.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.2.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.2.0 -> ssst0n3/docker_archive:ctr_nerdctl-v1.2.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.2.0_v0.1.0

## usage

```shell
$ cd nerdctl/v1.2.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-2-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser) 
root@nerdctl-1-2-0:~# nerdctl run --security-opt apparmor=unconfined hello-world

Hello from Docker!
...
root@nerdctl-1-2-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-2-0:~# nerdctl build -t foo .
root@nerdctl-1-2-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE        BLOB SIZE
foo            latest    c22ad2d84bca    22 seconds ago    linux/amd64    16.0 KiB    3.6 KiB
hello-world    latest    05813aedc15f    49 seconds ago    linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    49 seconds ago    linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-1-2-0:~# nerdctl --version
nerdctl version 1.2.0
root@nerdctl-1-2-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.11.2 944939944ca4cc58a11ace4af714083cfcd9a3c7
root@nerdctl-1-2-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.16 31aa4358a36870b21a992d3ad2bef29e1d693bec
root@nerdctl-1-2-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.2.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.2.0_v0.1.0
```

## Known Issue

### apparmor_parser

https://github.com/containerd/nerdctl/issues/3945

```
root@nerdctl-1-2-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
```