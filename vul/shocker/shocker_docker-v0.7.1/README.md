# shocker(docker v0.7.1)

* dqd: 
    * ssst0n3/docker_archive:shocker_docker-v0.7.1 -> ssst0n3/docker_archive:shocker_docker-v0.7.1_v0.1.0
    * ssst0n3/docker_archive:shocker_docker-v0.7.1_v0.1.0
* ctr: 
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.7.1 -> ssst0n3/docker_archive:ctr_shocker_docker-v0.7.1_v0.1.0
    * ssst0n3/docker_archive:ctr_shocker_docker-v0.7.1_v0.1.0

## reproduce

(docker v0.7.1 use registry v1, cannot pull image from dockerhub now.)

```shell
root@localhost:~# ./poc.sh 
+ echo 'loading docker image, docker-v0.7.1 cannot pull images from registry v2 anymore.'
loading docker image, docker-v0.7.1 cannot pull images from registry v2 anymore.
+ docker load
+ docker run -t -i busybox:ubuntu-12.04 grep Cap /proc/1/status
CapInh:	0000000000000000
CapPrm:	fffffffc904cfeff
CapEff:	fffffffc904cfeff
CapBnd:	fffffffc904cfeff
root@localhost:~# capsh --decode=fffffffc904cfeff
0xfffffffc904cfeff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_chroot,cap_sys_ptrace,cap_sys_boot,cap_lease,cap_setfcap,cap_syslog,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
root@localhost:~# cat /var/lib/docker/containers/0cf0fee0e041b73eeb433695c9fb6469a993c75a6e7c998c1f8091a90c59eca7/config.lxc  |grep cap
# drop linux capabilities (apply mainly to the user root in the container)
#  (Note: 'lxc.cap.keep' is coming soon and should replace this under the
lxc.cap.drop = audit_control audit_write mac_admin mac_override mknod setpcap sys_admin sys_module sys_nice sys_pacct sys_rawio sys_resource sys_time sys_tty_config
```

## env

```shell
cd vul/shocker/shocker_docker-v0.7.1
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
ssh -p 12711 root@127.0.0.1
```

```shell
root@localhost:~# docker version
Client version: 0.7.1
Go version (client): go1.2
Git commit (client): 88df052
Server version: 0.7.1
Git commit (server): 88df052
Go version (server): go1.2
Last stable version: 17.05.0-ce, please update docker
root@localhost:~# lxc-version 
lxc version: 0.7.5
```

## build

```shell
make all DIR=vul/shocker/shocker_docker-v0.7.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_shocker_docker-v0.7.1_v0.1.0
```
