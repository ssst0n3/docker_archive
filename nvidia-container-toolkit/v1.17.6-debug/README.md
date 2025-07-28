# nvidia-container-toolkit v1.17.6 debug

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6-debug -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6-debug_v0.3.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6-debug_v0.3.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6-debug_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6-debug_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6-debug -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6-debug_v0.3.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6-debug_v0.2.0: bump fake-nvidia to v0.7.1
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6-debug_v0.2.0: bump the base image; setup hostname
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6-debug_v0.1.0

## startup

```shell
$ cd nvidia-container-toolkit/v1.17.6-debug
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

## debug

```shell
root@localhost:~# ln -sf /root/runc.debug /usr/bin/runc
```

## usage

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-17-6-debug:~# docker run -tid --runtime=nvidia --gpus=all busybox
6c0d22aba743b479970c946bcf054544cef6ea4cb6dd9f45406df0ad4b2f2736
root@nvidia-container-toolkit-1-17-6-debug:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/6c0d22aba743b479970c946bcf054544cef6ea4cb6dd9f45406df0ad4b2f2736/config.json | jq .hooks
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
    }
  ],
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-ctk",
      "args": [
        "nvidia-ctk",
        "hook",
        "enable-cuda-compat",
        "--host-driver-version=575.57.08"
      ]
    },
    {
      "path": "/usr/bin/nvidia-ctk",
      "args": [
        "nvidia-ctk",
        "hook",
        "update-ldcache"
      ]
    }
  ]
}
```

### CDI mode

```shell
root@nvidia-container-toolkit-1-17-6-debug:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
INFO[0000] Using /usr/local/lib/libnvidia-ml.so.1       
INFO[0000] Auto-detected mode as 'nvml'                 
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
WARN[0000] Could not locate libnvidia-egl-gbm.so.*.*: pattern libnvidia-egl-gbm.so.*.* not found
libnvidia-egl-gbm.so.*.*: not found 
WARN[0000] Could not locate libnvidia-egl-wayland.so.*.*: pattern libnvidia-egl-wayland.so.*.* not found
libnvidia-egl-wayland.so.*.*: not found 
WARN[0000] Could not locate libnvidia-allocator.so.575.57.08: pattern libnvidia-allocator.so.575.57.08 not found
libnvidia-allocator.so.575.57.08: not found 
WARN[0000] Could not locate libnvidia-vulkan-producer.so.575.57.08: pattern libnvidia-vulkan-producer.so.575.57.08 not found
libnvidia-vulkan-producer.so.575.57.08: not found 
WARN[0000] Could not locate nvidia_drv.so: pattern nvidia_drv.so not found 
WARN[0000] Could not locate libglxserver_nvidia.so.575.57.08: pattern libglxserver_nvidia.so.575.57.08 not found 
WARN[0000] Could not locate glvnd/egl_vendor.d/10_nvidia.json: pattern glvnd/egl_vendor.d/10_nvidia.json not found 
WARN[0000] Could not locate egl/egl_external_platform.d/15_nvidia_gbm.json: pattern egl/egl_external_platform.d/15_nvidia_gbm.json not found 
WARN[0000] Could not locate egl/egl_external_platform.d/10_nvidia_wayland.json: pattern egl/egl_external_platform.d/10_nvidia_wayland.json not found 
WARN[0000] Could not locate nvidia/nvoptix.bin: pattern nvidia/nvoptix.bin not found 
WARN[0000] Could not locate X11/xorg.conf.d/10-nvidia.conf: pattern X11/xorg.conf.d/10-nvidia.conf not found 
WARN[0000] Could not locate X11/xorg.conf.d/nvidia-drm-outputclass.conf: pattern X11/xorg.conf.d/nvidia-drm-outputclass.conf not found 
WARN[0000] Could not locate vulkan/icd.d/nvidia_icd.json: pattern vulkan/icd.d/nvidia_icd.json not found
pattern vulkan/icd.d/nvidia_icd.json not found 
WARN[0000] Could not locate vulkan/icd.d/nvidia_layers.json: pattern vulkan/icd.d/nvidia_layers.json not found
pattern vulkan/icd.d/nvidia_layers.json not found 
WARN[0000] Could not locate vulkan/implicit_layer.d/nvidia_layers.json: pattern vulkan/implicit_layer.d/nvidia_layers.json not found
pattern vulkan/implicit_layer.d/nvidia_layers.json not found 
INFO[0000] Selecting /usr/local/lib/libcuda.so.575.57.08 as /usr/local/lib/libcuda.so.575.57.08 
WARN[0000] Could not locate /nvidia-persistenced/socket: pattern /nvidia-persistenced/socket not found 
WARN[0000] Could not locate /nvidia-fabricmanager/socket: pattern /nvidia-fabricmanager/socket not found 
WARN[0000] Could not locate /tmp/nvidia-mps: pattern /tmp/nvidia-mps not found 
WARN[0000] Could not locate nvidia/575.57.08/gsp*.bin: pattern nvidia/575.57.08/gsp*.bin not found 
WARN[0000] Could not locate nvidia-smi: pattern nvidia-smi not found 
WARN[0000] Could not locate nvidia-debugdump: pattern nvidia-debugdump not found 
WARN[0000] Could not locate nvidia-persistenced: pattern nvidia-persistenced not found 
WARN[0000] Could not locate nvidia-cuda-mps-control: pattern nvidia-cuda-mps-control not found 
WARN[0000] Could not locate nvidia-cuda-mps-server: pattern nvidia-cuda-mps-server not found 
WARN[0000] Could not locate nvidia-imex: pattern nvidia-imex not found 
WARN[0000] Could not locate nvidia-imex-ctl: pattern nvidia-imex-ctl not found 
WARN[0000] Could not locate libnvidia-egl-gbm.so.*.*: pattern libnvidia-egl-gbm.so.*.* not found
libnvidia-egl-gbm.so.*.*: not found 
WARN[0000] Could not locate libnvidia-egl-wayland.so.*.*: pattern libnvidia-egl-wayland.so.*.* not found
libnvidia-egl-wayland.so.*.*: not found 
WARN[0000] Could not locate libnvidia-allocator.so.575.57.08: pattern libnvidia-allocator.so.575.57.08 not found
libnvidia-allocator.so.575.57.08: not found 
WARN[0000] Could not locate libnvidia-vulkan-producer.so.575.57.08: pattern libnvidia-vulkan-producer.so.575.57.08 not found
libnvidia-vulkan-producer.so.575.57.08: not found 
WARN[0000] Could not locate nvidia_drv.so: pattern nvidia_drv.so not found 
WARN[0000] Could not locate libglxserver_nvidia.so.575.57.08: pattern libglxserver_nvidia.so.575.57.08 not found 
INFO[0000] Generated CDI spec with version 0.8.0        
root@nvidia-container-toolkit-1-17-6-debug:~# nvidia-ctk cdi list
INFO[0000] Found 9 CDI devices                          
nvidia.com/gpu=0
nvidia.com/gpu=1
nvidia.com/gpu=2
nvidia.com/gpu=3
nvidia.com/gpu=GPU-0-FAKE-UUID
nvidia.com/gpu=GPU-1-FAKE-UUID
nvidia.com/gpu=GPU-2-FAKE-UUID
nvidia.com/gpu=GPU-3-FAKE-UUID
nvidia.com/gpu=all
root@nvidia-container-toolkit-1-17-6-debug:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all busybox
d07423fd27fd24f8a7dcc37e5717eb2e5431f6a985125f241f954ac4c6e13370
root@nvidia-container-toolkit-1-17-6-debug:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/d07423fd27fd24f8a7dcc37e5717eb2e5431f6a985125f241f954ac4c6e13370/config.json | jq .hooks
{
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "create-symlinks",
        "--link",
        "libcuda.so.1::/usr/local/lib/libcuda.so"
      ]
    },
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "enable-cuda-compat",
        "--host-driver-version=575.57.08"
      ]
    },
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "update-ldcache",
        "--folder",
        "/usr/local/lib"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
$ ./ssh
root@nvidia-container-toolkit-1-17-6-debug:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-17-6-debug:~# lsmod |grep fake
fake_nvidia_driver     12288  0
root@nvidia-container-toolkit-1-17-6-debug:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 25 03:05 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-17-6-debug:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; preset: enabled)
     Active: inactive (dead) since Fri 2025-07-25 07:28:01 UTC; 4min 35s ago
    Process: 643 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 643 (code=exited, status=0/SUCCESS)
        CPU: 7ms

Jul 25 07:28:00 nvidia-container-toolkit-1-17-6-debug systemd[1]: Starting fake-nvidia-mknod.service - Create device nodes for fake nvidia driver...
Jul 25 07:28:01 nvidia-container-toolkit-1-17-6-debug systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 25 07:28:01 nvidia-container-toolkit-1-17-6-debug systemd[1]: Finished fake-nvidia-mknod.service - Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-17-6-debug:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.6
commit: e627eb2e21e167988e04c0579a1c941c1e263ff6
root@nvidia-container-toolkit-1-17-6-debug:~# docker info
Client: Docker Engine - Community
 Version:    28.1.1
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.20.1
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.33.1
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 2
  Running: 2
  Paused: 0
  Stopped: 0
 Images: 1
 Server Version: 28.1.1
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
 containerd version: 05044ec0a9a75232cad458027ca83437aae3f4da
 runc version: v1.2.5-0-g59923ef
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
 Name: nvidia-container-toolkit-1-17-6-debug
 ID: 6b85205a-47a5-4eae-bbfe-07687278cb01
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
make all DIR=nvidia-container-toolkit/v1.17.6-debug
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6-debug_v0.2.0
```
