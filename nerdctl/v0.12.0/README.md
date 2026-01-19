# nerdctl v0.12.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v0.12.0 -> ssst0n3/docker_archive:nerdctl-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v0.12.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v0.12.0 -> ssst0n3/docker_archive:ctr_nerdctl-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v0.12.0_v0.1.0

## usage

```shell
$ cd nerdctl/v0.12.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-0-12-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: exec: "apparmor_parser": executable file not found in $PATH 
root@nerdctl-0-12-0:~# nerdctl run --security-opt apparmor=unconfined hello-world

Hello from Docker!
...
root@nerdctl-0-12-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-0-12-0:~# nerdctl build -t foo .
root@nerdctl-0-12-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED                   SIZE
foo            latest    7f8da4787f56    Less than a second ago    16.0 KiB
hello-world    latest    05813aedc15f    39 seconds ago            16.0 KiB
```

```shell
$ ./ssh
root@nerdctl-0-12-0:~# nerdctl --version
nerdctl version 0.12.0
root@nerdctl-0-12-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.9.0 c8bb937807d405d92be91f06ce2629e6202ac7a9
root@nerdctl-0-12-0:~# containerd --version
containerd github.com/containerd/containerd v1.5.6 1a1b383ad5b520349f13f9715e0cd1e2f132c087
root@nerdctl-0-12-0:~# runc --version
runc version 1.0.2
commit: v1.0.2-0-g52b36a2dd837
spec: 1.0.2-dev
go: go1.16.7
libseccomp: 2.5.1
```

## build

```shell
make all DIR=nerdctl/v0.12.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v0.12.0_v0.1.0
```

## Known Issue

### apparmor_parser

https://github.com/containerd/nerdctl/issues/3945

```
root@nerdctl-0-12-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
```
