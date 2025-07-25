# nvidia-container-toolkit v1.13.0

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0_v0.1.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0_v0.1.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.13.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

https://web.archive.org/web/20230627162323/https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-13-0:~# docker run -tid --runtime=nvidia --gpus=all busybox
b82f14bd23a4822b3c89784440ff6fd6895e75252351a6e915cc64c07ae901dd
root@nvidia-container-toolkit-1-13-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/b82f14bd23a4822b3c89784440ff6fd6895e75252351a6e915cc64c07ae901dd/config.json | jq .hooks
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
      "path": "/proc/311/exe",
      "args": [
        "libnetwork-setkey",
        ...
      ]
    }
  ]
}
```

### CDI mode

```shell
root@nvidia-container-toolkit-1-13-0:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
INFO[0000] Auto-detected mode as "nvml"                 
INFO[0000] Selecting /dev/nvidia0 as /dev/nvidia0       
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--card; ignoring 
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--render; ignoring 
INFO[0000] Selecting /dev/nvidia1 as /dev/nvidia1       
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--card; ignoring 
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--render; ignoring 
INFO[0000] Selecting /dev/nvidia2 as /dev/nvidia2       
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--card; ignoring 
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--render; ignoring 
INFO[0000] Selecting /dev/nvidia3 as /dev/nvidia3       
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--card; ignoring 
WARN[0000] Failed to evaluate symlink /dev/dri/by-path/pci--render; ignoring 
INFO[0000] Using driver version 575.57.08               
WARN[0000] Could not locate /dev/nvidia-modeset: pattern /dev/nvidia-modeset not found 
WARN[0000] Could not locate /dev/nvidia-uvm-tools: pattern /dev/nvidia-uvm-tools not found 
WARN[0000] Could not locate /dev/nvidia-uvm: pattern /dev/nvidia-uvm not found 
INFO[0000] Selecting /dev/nvidiactl as /dev/nvidiactl   
WARN[0000] Could not locate libnvidia-egl-gbm.so: 64-bit library libnvidia-egl-gbm.so not found 
WARN[0000] Could not locate glvnd/egl_vendor.d/10_nvidia.json: pattern glvnd/egl_vendor.d/10_nvidia.json not found 
WARN[0000] Could not locate vulkan/icd.d/nvidia_icd.json: pattern vulkan/icd.d/nvidia_icd.json not found 
WARN[0000] Could not locate vulkan/implicit_layer.d/nvidia_layers.json: pattern vulkan/implicit_layer.d/nvidia_layers.json not found 
WARN[0000] Could not locate egl/egl_external_platform.d/15_nvidia_gbm.json: pattern egl/egl_external_platform.d/15_nvidia_gbm.json not found 
WARN[0000] Could not locate egl/egl_external_platform.d/10_nvidia_wayland.json: pattern egl/egl_external_platform.d/10_nvidia_wayland.json not found 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libcuda.so.575.57.08 as /lib/x86_64-linux-gnu/libcuda.so.575.57.08 
WARN[0000] Could not locate /nvidia-persistenced/socket: pattern /nvidia-persistenced/socket not found 
WARN[0000] Could not locate /nvidia-fabricmanager/socket: pattern /nvidia-fabricmanager/socket not found 
WARN[0000] Could not locate /tmp/nvidia-mps: pattern /tmp/nvidia-mps not found 
WARN[0000] Could not locate /lib/firmware/nvidia/575.57.08/gsp*.bin: pattern /lib/firmware/nvidia/575.57.08/gsp*.bin not found 
WARN[0000] Could not locate nvidia-smi: pattern nvidia-smi not found 
WARN[0000] Could not locate nvidia-debugdump: pattern nvidia-debugdump not found 
WARN[0000] Could not locate nvidia-persistenced: pattern nvidia-persistenced not found 
WARN[0000] Could not locate nvidia-cuda-mps-control: pattern nvidia-cuda-mps-control not found 
WARN[0000] Could not locate nvidia-cuda-mps-server: pattern nvidia-cuda-mps-server not found 
INFO[0000] Generated CDI spec with version 0.5.0        
root@nvidia-container-toolkit-1-13-0:~# grep "  name:" /etc/cdi/nvidia.yaml
  name: "0"
  name: "1"
  name: "2"
  name: "3"
  name: all
root@nvidia-container-toolkit-1-13-0:~# sed -i s/auto/cdi/g /etc/nvidia-container-runtime/config.toml
root@nvidia-container-toolkit-1-13-0:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all ubuntu
3d2173588c3eb8179037f852b9ef4af67177eae9c88a14763d747a9b4d15d6cc
root@nvidia-container-toolkit-1-13-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/3d2173588c3eb8179037f852b9ef4af67177eae9c88a14763d747a9b4d15d6cc/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/proc/311/exe",
      "args": [
        "libnetwork-setkey",
        "-exec-root=/var/run/docker",
        "3d2173588c3eb8179037f852b9ef4af67177eae9c88a14763d747a9b4d15d6cc",
        "b484c5a2ad24"
      ]
    }
  ],
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-ctk",
      "args": [
        "nvidia-ctk",
        "hook",
        "update-ldcache",
        "--folder",
        "/lib/x86_64-linux-gnu"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
root@nvidia-container-toolkit-1-13-0:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-13-0:~# lsmod |grep fake
fake_nvidia_driver     16384  0
root@nvidia-container-toolkit-1-13-0:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 25 14:11 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-13-0:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Fri 2025-07-25 14:48:31 UTC; 3min 23s ago
    Process: 432 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 432 (code=exited, status=0/SUCCESS)
        CPU: 14ms

Jul 25 14:48:31 nvidia-container-toolkit-1-13-0 systemd[1]: Starting Create device nodes for fake nvidia driver...
Jul 25 14:48:31 nvidia-container-toolkit-1-13-0 systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 25 14:48:31 nvidia-container-toolkit-1-13-0 systemd[1]: Finished Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-13-0:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.13.0
commit: b7079454b5b8fed1390ce78ca5a3343748f62657
root@nvidia-container-toolkit-1-13-0:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.10.4
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.17.2
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 2
  Running: 1
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 23.0.3
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
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1e1ea6e986c6c86565bc33d52e34b81b3e2bc71f
 runc version: v1.1.4-0-g5fd4c4d
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 5.15.0-144-generic
 Operating System: Ubuntu 22.04.5 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.918GiB
 Name: nvidia-container-toolkit-1-13-0
 ID: 46aac56d-fa77-4ca8-a59a-544cb6132fd0
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
root@nvidia-container-toolkit-1-13-0:~# containerd --version
containerd containerd.io 1.6.19 1e1ea6e986c6c86565bc33d52e34b81b3e2bc71f
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.13.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0_v0.1.0
```
