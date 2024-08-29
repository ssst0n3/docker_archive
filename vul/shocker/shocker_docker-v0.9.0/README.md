# shocker (docker v0.9.0)

* dqd: 
    * ssst0n3/docker_archive:shocker_docker-v0.9.0 -> ssst0n3/docker_archive:shocker_docker-v0.9.0_v0.1.0
    * ssst0n3/docker_archive:shocker_docker-v0.9.0_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.9.0 -> ssst0n3/docker_archive:ctr_shocker_docker-v0.9.0_v0.1.0
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.9.0_v0.1.0

## reproduce

(docker v0.9.0 use registry v1, cannot pull image from dockerhub now.)

* There's the CAP_DAC_READ_SEARCH
* There's no config.lxc.

```shell
root@localhost:~# ./poc.sh 
+ echo 'loading docker image, docker-v0.9.0 cannot pull images from registry v2 anymore.'
loading docker image, docker-v0.9.0 cannot pull images from registry v2 anymore.
+ docker load
+ docker run -t -i busybox:ubuntu-12.04 grep Cap /proc/1/status
CapInh:	0000000000000000
CapPrm:	fffffffc904ceeff
CapEff:	fffffffc904ceeff
CapBnd:	fffffffc904ceeff
root@localhost:~# capsh --decode=fffffffc904ceeff
0xfffffffc904ceeff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_chroot,cap_sys_ptrace,cap_sys_boot,cap_lease,cap_setfcap,cap_syslog,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63

root@localhost:~# ls -lah /var/lib/docker/containers/d22ce69506a640da5b511fa74b245614855e972bcbdf9f8f69e8acef86109f64/
total 36K
drwx------ 3 root root 4.0K Aug 29 02:32 .
drwx------ 3 root root 4.0K Aug 29 02:32 ..
-rw-r--r-- 1 root root  115 Aug 29 02:32 config.env
-rw-r--r-- 1 root root 1.3K Aug 29 02:32 config.json
-rw------- 1 root root  408 Aug 29 02:32 d22ce69506a640da5b511fa74b245614855e972bcbdf9f8f69e8acef86109f64-json.log
-rw-r--r-- 1 root root  122 Aug 29 02:32 hostconfig.json
-rw-r--r-- 1 root root   13 Aug 29 02:32 hostname
-rw-r--r-- 1 root root  180 Aug 29 02:32 hosts
drwxr-xr-x 2 root root 4.0K Aug 29 02:32 root
```

## env

```shell
cd vul/shocker/shocker_docker-v0.9.0
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 12092 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.9.0
Go version (client): go1.2.1
Git commit (client): 2b3fdf2
Server version: 0.9.0
Git commit (server): 2b3fdf2
Go version (server): go1.2.1
Last stable version: 17.05.0-ce, please update docker
```

## build

```shell
make all DIR=vul/shocker/shocker_docker-v0.9.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_shocker_docker-v0.9.0_v0.1.0
```
