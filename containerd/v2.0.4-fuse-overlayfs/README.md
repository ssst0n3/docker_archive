# containerd v2.0.4 with fuse-overlayfs

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.0.4-fuse-overlayfs -> ssst0n3/docker_archive:containerd-v2.0.4-fuse-overlayfs_v0.2.0
    * ssst0n3/docker_archive:containerd-v2.0.4-fuse-overlayfs_v0.2.0
    * ssst0n3/docker_archive:containerd-v2.0.4-fuse-overlayfs_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs -> ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs_v0.2.0
    * ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs_v0.2.0: bump the base image
    * ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs_v0.1.0

## usage

```shell
$ cd containerd/v2.0.4-fuse-overlayfs
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# systemctl status containerd-fuse-overlayfs
● containerd-fuse-overlayfs.service - containerd fuse-overlayfs snapshotter
     Loaded: loaded (/etc/systemd/system/containerd-fuse-overlayfs.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-05-14 04:00:34 UTC; 12min ago
   Main PID: 288 (containerd-fuse)
      Tasks: 5 (limit: 2329)
     Memory: 13.7M (peak: 14.5M)
        CPU: 15ms
     CGroup: /system.slice/containerd-fuse-overlayfs.service
             └─288 /usr/local/bin/containerd-fuse-overlayfs-grpc /run/containerd-fuse-overlayfs.sock /var/lib/containerd-fuse-overlayfs

May 14 04:00:34 localhost.localdomain systemd[1]: Starting containerd-fuse-overlayfs.service - containerd fuse-overlayfs snapshotter...
May 14 04:00:34 localhost.localdomain containerd-fuse-overlayfs-grpc[288]: time="2025-05-14T04:00:34Z" level=info msg="containerd-fuse-overlayfs-grpc Version=\"v2.1.2\" Revision=\"d6076ad2d8205d581a2e63227cd332aeeb656ef7\""
May 14 04:00:34 localhost.localdomain systemd[1]: Started containerd-fuse-overlayfs.service - containerd fuse-overlayfs snapshotter.
root@localhost:~# systemctl status containerd
● containerd.service - containerd container runtime
     Loaded: loaded (/usr/local/lib/systemd/system/containerd.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-05-14 04:00:34 UTC; 12min ago
       Docs: https://containerd.io
    Process: 308 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
   Main PID: 310 (containerd)
      Tasks: 8
     Memory: 72.2M (peak: 74.6M)
        CPU: 299ms
     CGroup: /system.slice/containerd.service
             └─310 /usr/local/bin/containerd

May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981640206Z" level=info msg="Start event monitor"
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981656251Z" level=info msg="Start cni network conf syncer for default"
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981659985Z" level=info msg=serving... address=/run/containerd/containerd.sock
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981660757Z" level=info msg="Start streaming server"
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981716578Z" level=info msg="Registered namespace \"k8s.io\" with NRI"
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981720948Z" level=info msg="runtime interface starting up..."
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981725338Z" level=info msg="starting plugins..."
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981733955Z" level=info msg="Synchronizing NRI (plugin) with current runtime state"
May 14 04:00:34 localhost.localdomain containerd[310]: time="2025-05-14T04:00:34.981787164Z" level=info msg="containerd successfully booted in 0.442875s"
May 14 04:00:34 localhost.localdomain systemd[1]: Started containerd.service - containerd container runtime.
```

```shell
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.4 1a43cb6a1035441f9aca8f5666a9b3ef9e70ab20
root@localhost:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@localhost:~# ctr i pull docker.io/library/ubuntu:24.04
root@localhost:~# ctr run docker.io/library/ubuntu:24.04 ctr id
uid=0(root) gid=0(root) groups=0(root)
```

## build

```shell
make all DIR=containerd/v2.0.4-fuse-overlayfs
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs_v0.2.0
```
