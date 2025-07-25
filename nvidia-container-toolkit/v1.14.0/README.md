# nvidia-container-toolkit v1.14.0

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0_v0.1.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0_v0.1.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.14.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-14-0:~# docker run -tid --runtime=nvidia --gpus=all busybox
86deff38c73ec1f2f7ee37933c180fb7c2623e0a45e46b6569610c77024ceb3f
root@nvidia-container-toolkit-1-14-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/86deff38c73ec1f2f7ee37933c180fb7c2623e0a45e46b6569610c77024ceb3f/config.json | jq .hooks
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
      "path": "/proc/310/exe",
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
root@nvidia-container-toolkit-1-14-0:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
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
WARN[0000] Could not locate nvidia/xorg/nvidia_drv.so: pattern nvidia/xorg/nvidia_drv.so not found 
WARN[0000] Could not locate nvidia/xorg/libglxserver_nvidia.so.575.57.08: pattern nvidia/xorg/libglxserver_nvidia.so.575.57.08 not found 
WARN[0000] Could not locate X11/xorg.conf.d/10-nvidia.conf: pattern X11/xorg.conf.d/10-nvidia.conf not found 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libcuda.so.575.57.08 as /lib/x86_64-linux-gnu/libcuda.so.575.57.08 
WARN[0000] Could not locate /nvidia-persistenced/socket: pattern /nvidia-persistenced/socket not found 
WARN[0000] Could not locate /nvidia-fabricmanager/socket: pattern /nvidia-fabricmanager/socket not found 
WARN[0000] Could not locate /tmp/nvidia-mps: pattern /tmp/nvidia-mps not found 
WARN[0000] Could not locate nvidia/575.57.08/gsp*.bin: pattern nvidia/575.57.08/gsp*.bin not found 
WARN[0000] Could not locate nvidia-smi: pattern nvidia-smi not found 
WARN[0000] Could not locate nvidia-debugdump: pattern nvidia-debugdump not found 
WARN[0000] Could not locate nvidia-persistenced: pattern nvidia-persistenced not found 
WARN[0000] Could not locate nvidia-cuda-mps-control: pattern nvidia-cuda-mps-control not found 
WARN[0000] Could not locate nvidia-cuda-mps-server: pattern nvidia-cuda-mps-server not found 
WARN[0000] Could not locate nvidia/xorg/nvidia_drv.so: pattern nvidia/xorg/nvidia_drv.so not found 
WARN[0000] Could not locate nvidia/xorg/libglxserver_nvidia.so.575.57.08: pattern nvidia/xorg/libglxserver_nvidia.so.575.57.08 not found 
INFO[0000] Generated CDI spec with version 0.5.0        
root@nvidia-container-toolkit-1-14-0:~# nvidia-ctk cdi list
INFO[0000] Found 5 CDI devices                          
nvidia.com/gpu=0
nvidia.com/gpu=1
nvidia.com/gpu=2
nvidia.com/gpu=3
nvidia.com/gpu=all
root@nvidia-container-toolkit-1-14-0:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all busybox
2cfa8a93f30b7ceff8e2b4f221e9e9ca6fb6e228c287cad13f6cf2b606021fd2
root@nvidia-container-toolkit-1-14-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/2cfa8a93f30b7ceff8e2b4f221e9e9ca6fb6e228c287cad13f6cf2b606021fd2/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/proc/310/exe",
      "args": [
        "libnetwork-setkey",
        "-exec-root=/var/run/docker",
        "2cfa8a93f30b7ceff8e2b4f221e9e9ca6fb6e228c287cad13f6cf2b606021fd2",
        "dc552da5b4e4"
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
root@nvidia-container-toolkit-1-14-0:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-14-0:~# lsmod |grep fake
fake_nvidia_driver     16384  0
root@nvidia-container-toolkit-1-14-0:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 25 13:28 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-14-0:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Fri 2025-07-25 13:36:15 UTC; 5min ago
    Process: 433 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 433 (code=exited, status=0/SUCCESS)
        CPU: 14ms

Jul 25 13:36:15 nvidia-container-toolkit-1-14-0 systemd[1]: Starting Create device nodes for fake nvidia driver...
Jul 25 13:36:15 nvidia-container-toolkit-1-14-0 systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 25 13:36:15 nvidia-container-toolkit-1-14-0 systemd[1]: Finished Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-14-0:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.14.0
commit: f2bd3173d44938eadb73252b866a9b3a7f44b8c6
root@nvidia-container-toolkit-1-14-0:~# docker info
Client: Docker Engine - Community
 Version:    24.0.5
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.11.2
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.20.2
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 2
  Running: 2
  Paused: 0
  Stopped: 0
 Images: 1
 Server Version: 24.0.5
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
 Runtimes: nvidia runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 3dce8eb055cbb6872793272b4f20ed16117344f8
 runc version: v1.1.7-0-g860f061
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
 Name: nvidia-container-toolkit-1-14-0
 ID: 4183a202-a55a-4ced-b5cb-ea80d461e63d
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
root@nvidia-container-toolkit-1-14-0:~# containerd --version
containerd containerd.io 1.6.21 3dce8eb055cbb6872793272b4f20ed16117344f8
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.14.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0_v0.2.0
```
