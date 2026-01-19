# nerdctl v0.20.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v0.20.0 -> ssst0n3/docker_archive:nerdctl-v0.20.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v0.20.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v0.20.0 -> ssst0n3/docker_archive:ctr_nerdctl-v0.20.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v0.20.0_v0.1.0

## usage

```shell
$ cd nerdctl/v0.20.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-0-20-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: exec: "apparmor_parser": executable file not found in $PATH 
root@nerdctl-0-20-0:~# nerdctl run --security-opt apparmor=unconfined hello-world

Hello from Docker!
...
root@nerdctl-0-20-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-0-20-0:~# nerdctl build -t foo .
root@nerdctl-0-20-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE        BLOB SIZE
foo            latest    1dc69bc2653d    1 second ago      linux/amd64    16.0 KiB    3.7 KiB
hello-world    latest    05813aedc15f    16 seconds ago    linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    16 seconds ago    linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-0-20-0:~# nerdctl --version
nerdctl version 0.20.0
root@nerdctl-0-20-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.10.3 c8d25d9a103b70dc300a4fd55e7e576472284e31
root@nerdctl-0-20-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.4 212e8b6fa2f44b9c21b2798135fc6fb7c53efc16
root@nerdctl-0-20-0:~# runc --version
runc version 1.0.0-rc95
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
```

## build

```shell
make all DIR=nerdctl/v0.20.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v0.20.0_v0.1.0
```

## Known Issue

### apparmor_parser

https://github.com/containerd/nerdctl/issues/3945

```
root@nerdctl-0-20-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser)
```
