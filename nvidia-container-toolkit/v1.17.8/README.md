# nvidia-container-toolkit v1.17.8

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.8 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.8_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.8_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.8_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.8 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.8_v0.2.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.8_v0.2.0: CDI compatible
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.8_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.17.8
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./SSH
```

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-17-8:~# docker run -tid --runtime=nvidia --gpus=all busybox
ab08e064cda4329d120a87380e0462ac143bf71094055ce88d52657794efdc2b
root@nvidia-container-toolkit-1-17-8:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/ab08e064cda4329d120a87380e0462ac143bf71094055ce88d52657794efdc2b/config.json | jq .hooks
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
  ]
}
```

### CDI mode

```shell
root@nvidia-container-toolkit-1-17-8:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
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
root@nvidia-container-toolkit-1-17-8:~# nvidia-ctk cdi list
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
root@nvidia-container-toolkit-1-17-8:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all busybox
18bd540d593ba5c8dbb5ba8a7cc272a5344aae3665e7b75dd0a9039c2a407aaf
root@nvidia-container-toolkit-1-17-8:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/18bd540d593ba5c8dbb5ba8a7cc272a5344aae3665e7b75dd0a9039c2a407aaf/config.json | jq .hooks
{
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "create-symlinks",
        "--link",
        "libcuda.so.1::/usr/local/lib/libcuda.so"
      ],
      "env": [
        "NVIDIA_CTK_DEBUG=false"
      ]
    },
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "enable-cuda-compat",
        "--host-driver-version=575.57.08"
      ],
      "env": [
        "NVIDIA_CTK_DEBUG=false"
      ]
    },
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "update-ldcache",
        "--folder",
        "/usr/local/lib"
      ],
      "env": [
        "NVIDIA_CTK_DEBUG=false"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
root@nvidia-container-toolkit-1-17-8:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-17-8:~# lsmod |grep fake
fake_nvidia_driver     12288  0
root@nvidia-container-toolkit-1-17-8:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 25 06:48 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-17-8:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; preset: enabled)
     Active: inactive (dead) since Fri 2025-07-25 06:54:53 UTC; 1min 30s ago
    Process: 643 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 643 (code=exited, status=0/SUCCESS)
        CPU: 6ms

Jul 25 06:54:53 nvidia-container-toolkit-1-17-8 systemd[1]: Starting fake-nvidia-mknod.service - Create device nodes for fake nvidia driver...
Jul 25 06:54:53 nvidia-container-toolkit-1-17-8 systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 25 06:54:53 nvidia-container-toolkit-1-17-8 systemd[1]: Finished fake-nvidia-mknod.service - Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-17-8:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.8
commit: f202b80a9b9d0db00d9b1d73c0128c8962c55f4d
root@nvidia-container-toolkit-1-17-8:~# docker info
Client: Docker Engine - Community
 Version:    28.2.0
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.24.0
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.36.2
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 28.2.0
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
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: nvidia runc io.containerd.runc.v2
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
 Name: nvidia-container-toolkit-1-17-8
 ID: 0ab3c740-ed67-4aab-a437-922df00cdb9f
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
make all DIR=nvidia-container-toolkit/v1.17.8
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.8_v0.2.0
```
