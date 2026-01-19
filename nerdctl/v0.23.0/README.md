# nerdctl v0.23.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v0.23.0 -> ssst0n3/docker_archive:nerdctl-v0.23.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v0.23.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v0.23.0 -> ssst0n3/docker_archive:ctr_nerdctl-v0.23.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v0.23.0_v0.1.0

## usage

```shell
$ cd nerdctl/v0.23.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-0-23-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
root@nerdctl-0-23-0:~# nerdctl run hello-world

Hello from Docker!
...
root@nerdctl-0-23-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-0-23-0:~# nerdctl build -t foo .
root@nerdctl-0-23-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED               PLATFORM       SIZE        BLOB SIZE
foo            latest    1dc69bc2653d    1 second ago          linux/amd64    16.0 KiB    3.7 KiB
hello-world    latest    05813aedc15f    About a minute ago    linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    About a minute ago    linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-0-23-0:~# nerdctl --version
nerdctl version 0.23.0
root@nerdctl-0-23-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.10.4 a2ba6869363812a210fcc3ded6926757ab780b5f
root@nerdctl-0-23-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.8 9cd3357b7fd7218e4aec3eae239db1f68a5a6ec6
root@nerdctl-0-23-0:~# runc --version
runc version 1.1.3
commit: v1.1.3-0-g6724737f
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v0.23.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v0.23.0_v0.1.0
```

## Known Issue

### apparmor_parser

https://github.com/containerd/nerdctl/issues/3945

```
root@nerdctl-0-23-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
```
