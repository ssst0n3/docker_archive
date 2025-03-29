# containerd v2.0.4 with fuse-overlayfs

* dqd: 
    * ssst0n3/docker_archive:containerd-v2.0.4-fuse-overlayfs -> ssst0n3/docker_archive:containerd-v2.0.4-fuse-overlayfs_v0.1.0
    * ssst0n3/docker_archive:containerd-v2.0.4-fuse-overlayfs_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs -> ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs_v0.1.0
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
     Active: active (running) since Sat 2025-03-29 12:38:33 UTC; 30s ago
   Main PID: 291 (containerd-fuse)
      Tasks: 5 (limit: 2329)
     Memory: 13.7M (peak: 14.3M)
        CPU: 14ms
     CGroup: /system.slice/containerd-fuse-overlayfs.service
             └─291 /usr/local/bin/containerd-fuse-overlayfs-grpc /run/containerd-fuse-overlayfs.sock /var/lib/containerd-fuse-overlayfs

Mar 29 12:38:32 localhost.localdomain systemd[1]: Starting containerd-fuse-overlayfs.service - containerd fuse-overlayfs snapshotter...
Mar 29 12:38:33 localhost.localdomain containerd-fuse-overlayfs-grpc[291]: time="2025-03-29T12:38:33Z" level=info msg="containerd-fuse-overlayfs-grpc Version=\"v2.1.2\" Revision=\"d6076ad2d8205d581a2e63227cd332aeeb656ef7\""
Mar 29 12:38:33 localhost.localdomain systemd[1]: Started containerd-fuse-overlayfs.service - containerd fuse-overlayfs snapshotter.
root@localhost:~# systemctl status containerd
● containerd.service - containerd container runtime
     Loaded: loaded (/usr/local/lib/systemd/system/containerd.service; enabled; preset: enabled)
     Active: active (running) since Sat 2025-03-29 12:38:33 UTC; 35s ago
       Docs: https://containerd.io
    Process: 311 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
   Main PID: 313 (containerd)
      Tasks: 7
     Memory: 72.1M (peak: 74.6M)
        CPU: 96ms
     CGroup: /system.slice/containerd.service
             └─313 /usr/local/bin/containerd

Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298090977Z" level=info msg="Start event monitor"
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298093211Z" level=info msg=serving... address=/run/containerd/containerd.sock
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298114368Z" level=info msg="Start cni network conf syncer for default"
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298118678Z" level=info msg="Start streaming server"
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298125558Z" level=info msg="Registered namespace \"k8s.io\" with NRI"
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298129999Z" level=info msg="runtime interface starting up..."
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298133307Z" level=info msg="starting plugins..."
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298140626Z" level=info msg="Synchronizing NRI (plugin) with current runtime state"
Mar 29 12:38:33 localhost.localdomain containerd[313]: time="2025-03-29T12:38:33.298211742Z" level=info msg="containerd successfully booted in 0.108433s"
Mar 29 12:38:33 localhost.localdomain systemd[1]: Started containerd.service - containerd container runtime.
```

```shell
root@localhost:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@localhost:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.4 1a43cb6a1035441f9aca8f5666a9b3ef9e70ab20
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
FROM ssst0n3/docker_archive:ctr_containerd-v2.0.4-fuse-overlayfs_v0.1.0
```