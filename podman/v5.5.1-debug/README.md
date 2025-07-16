# podman v5.5.1-debug

* dqd:
  * ssst0n3/docker_archive:podman-v5.5.1-debug -> ssst0n3/docker_archive:podman-v5.5.1-debug_v0.1.0
  * ssst0n3/docker_archive:podman-v5.5.1-debug_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_podman-v5.5.1-debug -> ssst0n3/docker_archive:ctr_podman-v5.5.1-debug_v0.1.0
  * ssst0n3/docker_archive:ctr_podman-v5.5.1-debug_v0.1.0

## usage

```shell
$ cd podman/v5.5.1-debug
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
[root@localhost ~]# ln -sf /usr/local/bin/debug.sh /usr/bin/podman
[root@localhost ~]# podman run -u nobody -ti --cap-add CAP_DAC_OVERRIDE ubuntu bash
API server listening at: [::]:2341
...
```


## build

```shell
make all DIR=podman/v5.5.1-debug
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_podman-v5.5.1-debug_v0.1.0
```
