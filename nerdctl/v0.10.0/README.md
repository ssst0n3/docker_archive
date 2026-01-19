# nerdctl v0.10.0

* dqd: 
   * ssst0n3/docker_archive:nerdctl-v0.10.0 -> ssst0n3/docker_archive:nerdctl-v0.10.0_v0.1.0
   * ssst0n3/docker_archive:nerdctl-v0.10.0_v0.1.0
* ctr:
   * ssst0n3/docker_archive:ctr_nerdctl-v0.10.0 -> ssst0n3/docker_archive:ctr_nerdctl-v0.10.0_v0.1.0
   * ssst0n3/docker_archive:ctr_nerdctl-v0.10.0_v0.1.0

## usage

```shell
$ cd nerdctl/v0.10.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-0-10-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: exec: "apparmor_parser": executable file not found in $PATH 
root@nerdctl-0-10-0:~# nerdctl run --security-opt apparmor=unconfined hello-world

Hello from Docker!
...
root@nerdctl-0-10-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-0-10-0:~# nerdctl build -t foo .
root@nerdctl-0-10-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED                   SIZE
foo            latest    7f8da4787f56    Less than a second ago    16.0 KiB
hello-world    latest    05813aedc15f    16 seconds ago            16.0 KiB
                         7f8da4787f56    Less than a second ago    16.0 KiB
```

```shell
$ ./ssh
root@nerdctl-0-10-0:~# nerdctl --version
nerdctl version 0.10.0
root@nerdctl-0-10-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.8.3 81c2cbd8a418918d62b71e347a00034189eea455
root@nerdctl-0-10-0:~# containerd --version
containerd github.com/containerd/containerd v1.5.2 36cc874494a56a253cd181a1a685b44b58a2e34a
root@nerdctl-0-10-0:~# runc --version
runc version 1.0.0-rc95
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
```

## build

```shell
make all DIR=nerdctl/v0.11.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v0.10.0_v0.1.0
```

## Known Issue

### apparmor_parser

https://github.com/containerd/nerdctl/issues/3945

```
root@nerdctl-0-10-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
```
