# shocker (docker v0.11.1)

* dqd: 
    * ssst0n3/docker_archive:shocker_docker-v0.11.1 -> ssst0n3/docker_archive:shocker_docker-v0.11.1_v0.1.0
    * ssst0n3/docker_archive:shocker_docker-v0.11.1_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.11.1 -> ssst0n3/docker_archive:ctr_shocker_docker-v0.11.1_v0.1.0
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.11.1_v0.1.0

## reproduce

(docker v0.11.1 use registry v1, cannot pull image from dockerhub now.)

* There's the CAP_DAC_READ_SEARCH
* There's no config.lxc.

```shell
root@localhost:~# ./poc.sh 
+ echo 'loading docker image, docker-v0.11.1 cannot pull images from registry v2 anymore.'
loading docker image, docker-v0.11.1 cannot pull images from registry v2 anymore.
+ docker load
+ docker run -ti busybox:1.36.1 grep Cap /proc/1/status
CapInh:	0000000000000000
CapPrm:	00000018984ceeff
CapEff:	00000018984ceeff
CapBnd:	00000018984ceeff
root@localhost:~# capsh --decode=00000018984ceeff
0x00000018984ceeff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_chroot,cap_sys_ptrace,cap_sys_boot,cap_mknod,cap_lease,cap_setfcap,cap_wake_alarm,cap_block_suspend

root@localhost:~# ls -lah /var/lib/docker/containers/eef92d06244261ef3ed339a37d5f381b8db5c328731c51e8d48023f478b6a47e/
total 28K
drwx------ 2 root root 4.0K Aug 30 11:27 .
drwx------ 3 root root 4.0K Aug 30 11:27 ..
-rw-r--r-- 1 root root 1.3K Aug 30 11:27 config.json
-rw------- 1 root root  408 Aug 30 11:27 eef92d06244261ef3ed339a37d5f381b8db5c328731c51e8d48023f478b6a47e-json.log
-rw-r--r-- 1 root root  192 Aug 30 11:27 hostconfig.json
-rw-r--r-- 1 root root   13 Aug 30 11:27 hostname
-rw-r--r-- 1 root root  174 Aug 30 11:27 hosts
```

## env

```shell
cd vul/shocker/shocker_docker-v0.11.1
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 11101 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.11.1
Client API version: 1.11
Go version (client): go1.2.1
Git commit (client): fb99f99
Server version: 0.11.1
Server API version: 1.11
Git commit (server): fb99f99
Go version (server): go1.2.1
Last stable version: 17.05.0-ce, please update docker
```

## build

```shell
make all DIR=vul/shocker/shocker_docker-v0.11.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_shocker_docker-v0.11.1_v0.1.0
```
