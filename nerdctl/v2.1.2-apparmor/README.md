# nerdctl v2.1.2 with apparmor

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v2.1.2-apparmor -> ssst0n3/docker_archive:nerdctl-v2.1.2-apparmor_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v2.1.2-apparmor_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v2.1.2-apparmor -> ssst0n3/docker_archive:ctr_nerdctl-v2.1.2-apparmor_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v2.1.2-apparmor_v0.1.0

## usage

```shell
$ cd nerdctl/v2.1.2-apparmor
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### apparmor

```shell
$ ./ssh
root@nerdctl-2-1-2-apparmor:~# nerdctl run -ti busybox cat /proc/self/attr/current
nerdctl-default (enforce)
```

### build

```shell
$ ./ssh
root@nerdctl-2-1-2-apparmor:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-2-1-2-apparmor:~# nerdctl build -t foo .
root@nerdctl-2-1-2-apparmor:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE       BLOB SIZE
foo            latest    f35374a8a2f6    3 seconds ago     linux/amd64    16.38kB    3.426kB
...
```

### env details

```shell
$ ./ssh
root@nerdctl-2-1-2-apparmor:~# nerdctl --version
nerdctl version 2.1.2
root@nerdctl-2-1-2-apparmor:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.21.1 66735c67040bc80e6ed104f451683e094030a4e1
root@nerdctl-2-1-2-apparmor:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.1 cb1076646aa3740577fafbf3d914198b7fe8e3f7
root@nerdctl-2-1-2-apparmor:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
```

## build

```shell
make all DIR=nerdctl/v2.1.2-apparmor
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v2.1.2-apparmor_v0.1.0
```
