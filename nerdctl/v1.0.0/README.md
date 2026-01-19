# nerdctl v1.0.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v1.0.0 -> ssst0n3/docker_archive:nerdctl-v1.0.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v1.0.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v1.0.0 -> ssst0n3/docker_archive:ctr_nerdctl-v1.0.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v1.0.0_v0.1.0

## usage

```shell
$ cd nerdctl/v1.0.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nerdctl-1-0-0:~# nerdctl run hello-world
FATA[0000] get apparmor_parser version: apparmor_parser resolves to executable in current directory (./apparmor_parser) 
root@nerdctl-1-0-0:~# nerdctl run --security-opt apparmor=unconfined hello-world

Hello from Docker!
...
root@nerdctl-1-0-0:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-1-0-0:~# nerdctl build -t foo .
root@nerdctl-1-0-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE        BLOB SIZE
foo            latest    1dc69bc2653d    1 second ago      linux/amd64    16.0 KiB    3.7 KiB
hello-world    latest    05813aedc15f    31 seconds ago    linux/amd64    16.0 KiB    15.9 KiB
hello-world    latest    05813aedc15f    31 seconds ago    linux/386      0.0 B       16.1 KiB
```

```shell
$ ./ssh
root@nerdctl-1-0-0:~# nerdctl --version
nerdctl version 1.0.0
root@nerdctl-1-0-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.10.4 ca87e0c4450a86f3f7252a6f6c9f2cf48a23b53c
root@nerdctl-1-0-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.8 9cd3357b7fd7218e4aec3eae239db1f68a5a6ec6
root@nerdctl-1-0-0:~# runc --version
runc version 1.1.0
commit: v1.1.0-0-g067aaf85
spec: 1.0.2-dev
go: go1.18.5
libseccomp: 2.5.4
```

## build

```shell
make all DIR=nerdctl/v1.0.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v1.0.0_v0.1.0
```
