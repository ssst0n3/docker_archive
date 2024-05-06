
## use

## build

build as a ctr

```
$ docker build -t ssst0n3/docker_archive:ctr_ubuntu-22.04_runc-v1.1.12_v0.1.0 .
```


build as a vm

```
./build.sh
```

```
$ qemu-system-x86_64 -m 2048M -hda vm.qcow2 -net nic -net user,hostfwd=tcp::2222-:22 -smp 2 -nographic -enable-kvm
Ubuntu 22.04.4 LTS localhost.localdomain ttyS0

localhost login: root
Password: root 
...
root@localhost:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
```

build as a docker-in-qemu-in-docker

```
```