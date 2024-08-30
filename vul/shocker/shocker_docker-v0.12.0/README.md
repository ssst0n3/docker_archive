# shocker (docker v0.12.0)

* dqd: 
    * ssst0n3/docker_archive:shocker_docker-v0.12.0 -> ssst0n3/docker_archive:shocker_docker-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:shocker_docker-v0.12.0_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0 -> ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0_v0.1.0
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0_v0.1.0

## reproduce

(docker v0.12.0 use registry v1, cannot pull image from dockerhub now.)

* There's no CAP_DAC_READ_SEARCH
* There's no config.lxc.

```shell
root@localhost:~# ./poc.sh 
+ echo 'loading docker image, docker-v0.12.0 cannot pull images from registry v2 anymore.'
loading docker image, docker-v0.12.0 cannot pull images from registry v2 anymore.
+ docker load
+ docker run -ti busybox:1.36.1 grep Cap /proc/1/status
CapInh:	00000000880425cb
CapPrm:	00000000880425cb
CapEff:	00000000880425cb
CapBnd:	00000000880425cb
root@localhost:~# capsh --decode=00000000880425cb
0x00000000880425cb=cap_chown,cap_dac_override,cap_fowner,cap_setgid,cap_setuid,cap_setpcap,cap_net_bind_service,cap_net_raw,cap_sys_chroot,cap_mknod,cap_setfcap
root@localhost:~# 
root@localhost:~# ls -lah /var/lib/docker/containers/b0df3f596b05228360a8010fc78c504f69361a2ef793b5a04f008729fc308491/
total 28K
drwx------ 2 root root 4.0K Aug 30 12:19 .
drwx------ 3 root root 4.0K Aug 30 12:19 ..
-rw------- 1 root root  408 Aug 30 12:19 b0df3f596b05228360a8010fc78c504f69361a2ef793b5a04f008729fc308491-json.log
-rw-r--r-- 1 root root 1.3K Aug 30 12:19 config.json
-rw-r--r-- 1 root root  192 Aug 30 12:19 hostconfig.json
-rw-r--r-- 1 root root   13 Aug 30 12:19 hostname
-rw-r--r-- 1 root root  174 Aug 30 12:19 hosts
```

## env

```shell
cd vul/shocker/shocker_docker-v0.12.0
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 14121 root@127.0.0.1
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
```

## build

```shell
make all DIR=vul/shocker/shocker_docker-v0.12.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_shocker_docker-v0.12.0_v0.1.0
```
