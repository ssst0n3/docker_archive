# shocker (docker v0.12.0 lxc)

* dqd: 
    * ssst0n3/docker_archive:shocker_docker-v0.12.0-lxc -> ssst0n3/docker_archive:shocker_docker-v0.12.0-lxc_v0.1.0
    * ssst0n3/docker_archive:shocker_docker-v0.12.0-lxc_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0-lxc -> ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0-lxc_v0.1.0
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0-lxc_v0.1.0

## reproduce

(docker v0.12.0 use registry v1, cannot pull image from dockerhub now.)

* There's CAP_DAC_READ_SEARCH
* There's no `lxc.cap.drop` in config.lxc.

```shell
root@localhost:~# ./poc.sh 
+ echo 'loading docker image, docker-v0.12.0 cannot pull images from registry v2 anymore.'
loading docker image, docker-v0.12.0 cannot pull images from registry v2 anymore.
+ docker load
+ docker run -ti busybox:1.36.1 grep Cap /proc/1/status
CapInh:	0000000000000000
CapPrm:	00000018984ceeff
CapEff:	00000018984ceeff
CapBnd:	00000018984ceeff
root@localhost:~# capsh --decode=00000018984ceeff
0x00000018984ceeff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_chroot,cap_sys_ptrace,cap_sys_boot,cap_mknod,cap_lease,cap_setfcap,cap_wake_alarm,cap_block_suspend
root@localhost:~# 
root@localhost:~# cat /var/lib/docker/containers/c1885da6a51b6281aade7b3a580178b1d89d54d59e649a8d86d6b53d1ebb627b/config.lxc |grep cap
```

## env

```shell
cd vul/shocker/shocker_docker-v0.12.0-lxc
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 14123 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.12.0
Client API version: 1.12
Go version (client): go1.2.1
Git commit (client): 14680bf
Server version: 0.12.0
Server API version: 1.12
Go version (server): go1.2.1
Git commit (server): 14680bf
root@localhost:~# lxc-start --version
1.0.10
```

## build

```shell
make all DIR=vul/shocker/shocker_docker-v0.12.0-lxc
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0-lxc_v0.1.0
```
