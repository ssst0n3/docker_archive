# nvidia-container-toolkit v1.10.0

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.10.0 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.10.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.10.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.10.0_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.10.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.10.0 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.10.0_v0.9.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.10.0_v0.9.0: install real nvidia driver without kernel module; install i386 libs; bump fake-nvidia to v0.7.2
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.10.0_v0.2.0: bump fake-nvidia to v0.7.1
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.10.0_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.10.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.10.0/install-guide.html

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-10-0:~# docker run -tid --runtime=nvidia --gpus=all busybox
6ee581684513b08ffd983db39fbdf8aea5fda0567e3b12fd6badbbca6d08babd
root@nvidia-container-toolkit-1-10-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/6ee581684513b08ffd983db39fbdf8aea5fda0567e3b12fd6badbbca6d08babd/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/usr/bin/nvidia-container-runtime-hook",
      "args": [
        "nvidia-container-runtime-hook",
        "prestart"
      ],
      "env": [
        ...
      ]
    },
    {
      "path": "/proc/313/exe",
      "args": [
        "libnetwork-setkey",
        ...
      ]
    }
  ]
}
```

### CDI mode

nvidia-container-toolkit v1.10.0 has not support CDI mode yet.

### CSV mode

```shell
root@nvidia-container-toolkit-1-10-0:~# sed -i s/auto/csv/g /etc/nvidia-container-runtime/config.toml 
root@nvidia-container-toolkit-1-10-0:~# docker run -tid --runtime=nvidia --gpus=all busybox
82f232890cedf5598a544eb7c2729e3096d95cef7f6bd0a05a70c345436ea904
root@nvidia-container-toolkit-1-10-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/82f232890cedf5598a544eb7c2729e3096d95cef7f6bd0a05a70c345436ea904/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/proc/313/exe",
      "args": [
        "libnetwork-setkey",
        ...
      ]
    }
  ],
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-ctk",
      "args": [
        "/usr/bin/nvidia-ctk",
        "hook",
        "update-ldcache"
      ]
    },
    {
      "path": "/usr/bin/nvidia-ctk",
      "args": [
        "/usr/bin/nvidia-ctk",
        "hook",
        "create-symlinks"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
root@nvidia-container-toolkit-1-10-0:~# nvidia-container-cli info
NVRM version:   575.57.08
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
root@nvidia-container-toolkit-1-10-0:~# lsmod |grep fake
fake_nvidia_driver     16384  0
root@nvidia-container-toolkit-1-10-0:~# ls -lah /usr/lib/x86_64-linux-gnu/libnvidia-ml.so*
lrwxrwxrwx 1 root root  43 Jul 30 09:11 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
lrwxrwxrwx 1 root root  51 Jul 30 09:11 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
-rwxr-xr-x 1 root root 22K Jul 30 09:11 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
root@nvidia-container-toolkit-1-10-0:~# systemctl status fake-nvidia-device
○ fake-nvidia-device.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-device.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Wed 2025-07-30 09:19:05 UTC; 3min 32s ago
    Process: 461 ExecStart=/usr/local/bin/fake-nvidia-device.sh (code=exited, status=0/SUCCESS)
   Main PID: 461 (code=exited, status=0/SUCCESS)
        CPU: 9ms

Jul 30 09:19:05 nvidia-container-toolkit-1-10-0 systemd[1]: Starting Create device nodes for fake nvidia driver...
Jul 30 09:19:05 nvidia-container-toolkit-1-10-0 systemd[1]: fake-nvidia-device.service: Deactivated successfully.
Jul 30 09:19:05 nvidia-container-toolkit-1-10-0 systemd[1]: Finished Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-10-0:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.10.0
commit: 7cfd3bd
root@nvidia-container-toolkit-1-10-0:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Docker Buildx (Docker Inc., v0.8.2-docker)
  scan: Docker Scan (Docker Inc., v0.23.0)

Server:
 Containers: 2
  Running: 2
  Paused: 0
  Stopped: 0
 Images: 1
 Server Version: 20.10.17
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: nvidia runc io.containerd.runc.v2 io.containerd.runtime.v1.linux
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 10c12954828e7c7c9b6e0ea9b0c02b01407d3ae1
 runc version: v1.1.2-0-ga916309
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: default
  cgroupns
 Kernel Version: 5.15.0-151-generic
 Operating System: Ubuntu 22.04.5 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.918GiB
 Name: nvidia-container-toolkit-1-10-0
 ID: JMKT:DZYN:OAFH:X7W7:MJYA:HPJE:EGTE:WYHN:4T4N:CN4N:DFRF:OEQM
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

root@nvidia-container-toolkit-1-10-0:~# containerd --version
containerd containerd.io 1.6.6 10c12954828e7c7c9b6e0ea9b0c02b01407d3ae1
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.10.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.10.0_v0.9.0
```
