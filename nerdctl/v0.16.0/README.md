# nerdctl v0.16.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v0.16.0 -> ssst0n3/docker_archive:nerdctl-v0.16.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v0.16.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v0.16.0 -> ssst0n3/docker_archive:ctr_nerdctl-v0.16.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v0.16.0_v0.1.0

## usage

```shell
$ cd nerdctl/v0.16.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-0-16-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: exec: "apparmor_parser": executable file not found in $PATH 
root@nerdctl-0-16-0:~# nerdctl run --security-opt apparmor=unconfined hello-world

Hello from Docker!
...
root@nerdctl-0-16-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-0-16-0:~# nerdctl build -t foo .
root@nerdctl-0-16-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED                   PLATFORM       SIZE
foo            latest    7f8da4787f56    Less than a second ago    linux/amd64    16.0 KiB
hello-world    latest    05813aedc15f    9 seconds ago             linux/amd64    16.0 KiB
hello-world    latest    05813aedc15f    9 seconds ago             linux/386      0.0 B
```

```shell
$ ./ssh
root@nerdctl-0-16-0:~# nerdctl --version
nerdctl version 0.16.0
root@nerdctl-0-16-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.9.3 8d2625494a6a3d413e3d875a2ff7dd9b1ed1b1a9
root@nerdctl-0-16-0:~# containerd --version
containerd github.com/containerd/containerd v1.5.9 1407cab509ff0d96baa4f0eb6ff9980270e6e620
root@nerdctl-0-16-0:~# runc --version
runc version 1.0.3
commit: v1.0.3-0-gf46b6ba2c931
spec: 1.0.2-dev
go: go1.17.3
libseccomp: 2.5.1
```

## build

```shell
make all DIR=nerdctl/v0.16.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v0.16.0_v0.1.0
```

## Known Issue

### apparmor_parser

https://github.com/containerd/nerdctl/issues/3945

```
root@nerdctl-0-16-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
```
