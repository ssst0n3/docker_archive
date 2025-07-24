# nvidia-container-toolkit v1.17.5

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.5 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.5_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.5_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.5_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.5 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.5_v0.2.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.5_v0.2.0: setup the hostname
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.5_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.17.5
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@nvidia-container-toolkit-1-17-5:~# docker run -ti --runtime=nvidia --gpus=all busybox
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
90b9666d4aed: Pull complete 
Digest: sha256:f85340bf132ae937d2c2a763b8335c9bab35d6e8293f70f606b9c6178d84f42b
Status: Downloaded newer image for busybox:latest
/ # 
```

```shell
$ ./ssh
root@nvidia-container-toolkit-1-17-5:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.5
commit: f785e908a7f72149f8912617058644fd84e38cde
root@nvidia-container-toolkit-1-17-5:~# lsmod |grep fake
fake_nvidia_driver     12288  0
root@nvidia-container-toolkit-1-17-5:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 24 09:32 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-17-5:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; preset: enabled)
     Active: inactive (dead) since Thu 2025-07-24 09:36:28 UTC; 45s ago
    Process: 635 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 635 (code=exited, status=0/SUCCESS)
        CPU: 7ms

Jul 24 09:36:28 nvidia-container-toolkit-1-17-5 systemd[1]: Starting fake-nvidia-mknod.service - Create device nodes for fake nvidia driver...
Jul 24 09:36:28 nvidia-container-toolkit-1-17-5 systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 24 09:36:28 nvidia-container-toolkit-1-17-5 systemd[1]: Finished fake-nvidia-mknod.service - Create device nodes for fake nvidia driver.
root@nvidia-container-toolkit-1-17-5:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-17-5:~# docker info
Client: Docker Engine - Community
 Version:    28.0.1
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.20.1
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.32.4
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 28.0.1
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
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
 runc version: v1.2.4-0-g6c52b3f
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
 Name: nvidia-container-toolkit-1-17-5
 ID: b654d216-c687-4559-aa6b-0310db323f7f
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.17.5
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.5_v0.2.0
```
