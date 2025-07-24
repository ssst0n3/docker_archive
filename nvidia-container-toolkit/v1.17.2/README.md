# nvidia-container-toolkit v1.17.2

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.2 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.2_v0.1.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.2_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.2 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.2_v0.1.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.2_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.17.2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nvidia-container-toolkit-1-17-2:~# docker run -ti --runtime=nvidia --gpus=all busybox
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
90b9666d4aed: Pull complete 
Digest: sha256:f85340bf132ae937d2c2a763b8335c9bab35d6e8293f70f606b9c6178d84f42b
Status: Downloaded newer image for busybox:latest
/ # 
```

```shell
$ ./ssh
root@nvidia-container-toolkit-1-17-2:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.2
commit: fa66e4cd562804509055e44a88f666673e6d27c0
root@nvidia-container-toolkit-1-17-2:~# lsmod |grep fake
fake_nvidia_driver     12288  0
root@nvidia-container-toolkit-1-17-2:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 24 07:51 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-17-2:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; preset: enabled)
     Active: inactive (dead) since Thu 2025-07-24 08:52:18 UTC; 1min 4s ago
    Process: 622 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 622 (code=exited, status=0/SUCCESS)
        CPU: 9ms

Jul 24 08:52:18 nvidia-container-toolkit-1-17-2 systemd[1]: Starting fake-nvidia-mknod.service - Create device nodes for fake nvidia driver...
Jul 24 08:52:18 nvidia-container-toolkit-1-17-2 systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 24 08:52:18 nvidia-container-toolkit-1-17-2 systemd[1]: Finished fake-nvidia-mknod.service - Create device nodes for fake nvidia driver.
root@nvidia-container-toolkit-1-17-2:~# nvidia-container-cli info
NVRM version:   535.104.05
CUDA version:   12.2

Device Index:   0
Device Minor:   0
Model:          NVIDIA Tesla T4
Brand:          Tesla
GPU UUID:       GPU-0-FAKE-UUID
Bus Location:   00000000:00:00.0
Architecture:   7.5

Device Index:   1
Device Minor:   1
Model:          NVIDIA Tesla T4
Brand:          Tesla
GPU UUID:       GPU-1-FAKE-UUID
Bus Location:   00000000:00:00.0
Architecture:   7.5

Device Index:   2
Device Minor:   2
Model:          NVIDIA Tesla T4
Brand:          Tesla
GPU UUID:       GPU-2-FAKE-UUID
Bus Location:   00000000:00:00.0
Architecture:   7.5

Device Index:   3
Device Minor:   3
Model:          NVIDIA Tesla T4
Brand:          Tesla
GPU UUID:       GPU-3-FAKE-UUID
Bus Location:   00000000:00:00.0
Architecture:   7.5
root@nvidia-container-toolkit-1-17-2:~# docker info
Client: Docker Engine - Community
 Version:    27.3.1
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.17.1
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.29.4
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 27.3.1
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 Swarm: inactive
 Runtimes: nvidia runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 7f7fdf5fed64eb6a7caf99b3e12efcf9d60e311c
 runc version: v1.1.14-0-g2c9f560
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.8.0-64-generic
 Operating System: Ubuntu 24.04.2 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.922GiB
 Name: nvidia-container-toolkit-1-17-2
 ID: 299751f8-1496-49ae-9db1-8e05757cc21e
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

WARNING: bridge-nf-call-iptables is disabled
WARNING: bridge-nf-call-ip6tables is disabled
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.17.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.2_v0.1.0
```
