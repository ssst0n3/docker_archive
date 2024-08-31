# shocker (docker v1.0.1 lxc)

* dqd: 
    * ssst0n3/docker_archive:shocker_docker-v1.0.1-lxc -> ssst0n3/docker_archive:shocker_docker-v1.0.1-lxc_v0.1.0
    * ssst0n3/docker_archive:shocker_docker-v1.0.1-lxc_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_shocker_docker-v1.0.1-lxc -> ssst0n3/docker_archive:ctr_shocker_docker-v1.0.1-lxc_v0.1.0
    * ssst0n3/docker_archive:ctr_shocker_docker-v1.0.1-lxc_v0.1.0

## reproduce

(docker v1.0.1 use registry v1, cannot pull image from dockerhub now.)

* There's no CAP_DAC_READ_SEARCH
* There's no `lxc.cap.drop` in config.lxc.

```shell
root@localhost:~# ./poc.sh 
+ echo 'loading docker image, docker-v1.0.1 cannot pull images from registry v2 anymore.'
loading docker image, docker-v1.0.1 cannot pull images from registry v2 anymore.
+ docker load
+ docker run -ti busybox:1.36.1 grep Cap /proc/1/status
CapInh:	00000000880425eb
CapPrm:	00000000880425eb
CapEff:	00000000880425eb
CapBnd:	00000000880425eb
root@localhost:~# capsh --decode=00000000880425eb
0x00000000880425eb=cap_chown,cap_dac_override,cap_fowner,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_net_bind_service,cap_net_raw,cap_sys_chroot,cap_mknod,cap_setfcap
root@localhost:~# cat /var/lib/docker/containers/b53742828d187fb9548d95e4bb182dd6bed774df138f91cd87af8321c4eda1f6/config.lxc |grep cap
```

## env

```shell
cd vul/shocker/shocker_docker-v1.0.1-lxc
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 14103 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 1.0.1
Client API version: 1.12
Go version (client): go1.2.1
Git commit (client): 990021a
Server version: 1.0.1
Server API version: 1.12
Go version (server): go1.2.1
Git commit (server): 990021a
root@localhost:~# lxc-start --version
1.0.10
```

## build

```shell
make all DIR=vul/shocker/shocker_docker-v1.0.1-lxc
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_shocker_docker-v1.0.1-lxc_v0.1.0
```
