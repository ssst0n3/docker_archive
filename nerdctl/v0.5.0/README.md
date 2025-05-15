# nerdctl v0.5.0

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v0.5.0 -> ssst0n3/docker_archive:nerdctl-v0.5.0_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v0.5.0_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v0.5.0 -> ssst0n3/docker_archive:ctr_nerdctl-v0.5.0_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v0.5.0_v0.1.0

## usage

```shell
$ cd nerdctl/v0.5.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# nerdctl run hello-world

Hello from Docker!
...
root@localhost:~# echo 'FROM hello-world' > Dockerfile
root@localhost:~# nerdctl build -t foo .
root@localhost:~# nerdctl images
REPOSITORY          TAG                                                                 IMAGE ID        CREATED           SIZE
foo                 latest                                                              69f77b606f50    8 seconds ago     3.4 KiB
hello-world         latest                                                              dd01f97f2521    26 seconds ago    16.3 KiB
overlayfs@sha256    69f77b606f50e9916d51c37132f4351a2d8d31dc0d95b95dce68a4cf6ba4ace1    69f77b606f50    8 seconds ago     3.4 KiB
```

```shell
$ ./ssh
root@localhost:~# nerdctl --version
nerdctl version 0.5.0
root@localhost:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.8.1 8142d66b5ebde79846b869fba30d9d30633e74aa
root@localhost:~# containerd --version
containerd github.com/containerd/containerd v1.4.3 269548fa27e0089a8b8278fc4fc781d7f65a939b
root@localhost:~# runc --version
runc version 1.0.0-rc92
spec: 1.0.2-dev
```

## build

```shell
make all DIR=nerdctl/v0.5.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v0.5.0_v0.1.0
```
