# nvidia-container-toolkit v1.16.2

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.16.2 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.16.2_v0.3.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.16.2_v0.3.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.16.2_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.16.2_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.16.2 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.16.2_v0.3.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.16.2_v0.3.0: bump fake-nvidia to v0.7.1
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.16.2_v0.2.0: CDI compatible
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.16.2_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.16.2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-16-2:~# docker run -tid --runtime=nvidia --gpus=all busybox
bd58d210e2bdeb77d56b5c6492284f1d22cd3dafb93abd27b033de3870d805c6
root@nvidia-container-toolkit-1-16-2:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/bd58d210e2bdeb77d56b5c6492284f1d22cd3dafb93abd27b033de3870d805c6/config.json | jq .hooks
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
      "path": "/proc/430/exe",
      "args": [
        "libnetwork-setkey",
        ...
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
root@nvidia-container-toolkit-1-16-2:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
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
64-bit library libnvidia-egl-gbm.so.*.*: not found 
WARN[0000] Could not locate libnvidia-egl-wayland.so.*.*: pattern libnvidia-egl-wayland.so.*.* not found
64-bit library libnvidia-egl-wayland.so.*.*: not found 
WARN[0000] Could not locate libnvidia-allocator.so.575.57.08: pattern libnvidia-allocator.so.575.57.08 not found
64-bit library libnvidia-allocator.so.575.57.08: not found 
WARN[0000] Could not locate libnvidia-vulkan-producer.so.575.57.08: pattern libnvidia-vulkan-producer.so.575.57.08 not found
64-bit library libnvidia-vulkan-producer.so.575.57.08: not found 
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
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libcuda.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libcuda.so.575.57.08 
WARN[0000] Could not locate /nvidia-persistenced/socket: pattern /nvidia-persistenced/socket not found 
WARN[0000] Could not locate /nvidia-fabricmanager/socket: pattern /nvidia-fabricmanager/socket not found 
WARN[0000] Could not locate /tmp/nvidia-mps: pattern /tmp/nvidia-mps not found 
WARN[0000] Could not locate nvidia/575.57.08/gsp*.bin: pattern nvidia/575.57.08/gsp*.bin not found 
WARN[0000] Could not locate nvidia-smi: pattern nvidia-smi not found 
WARN[0000] Could not locate nvidia-debugdump: pattern nvidia-debugdump not found 
WARN[0000] Could not locate nvidia-persistenced: pattern nvidia-persistenced not found 
WARN[0000] Could not locate nvidia-cuda-mps-control: pattern nvidia-cuda-mps-control not found 
WARN[0000] Could not locate nvidia-cuda-mps-server: pattern nvidia-cuda-mps-server not found 
WARN[0000] Could not locate libnvidia-egl-gbm.so.*.*: pattern libnvidia-egl-gbm.so.*.* not found
64-bit library libnvidia-egl-gbm.so.*.*: not found 
WARN[0000] Could not locate libnvidia-egl-wayland.so.*.*: pattern libnvidia-egl-wayland.so.*.* not found
64-bit library libnvidia-egl-wayland.so.*.*: not found 
WARN[0000] Could not locate libnvidia-allocator.so.575.57.08: pattern libnvidia-allocator.so.575.57.08 not found
64-bit library libnvidia-allocator.so.575.57.08: not found 
WARN[0000] Could not locate libnvidia-vulkan-producer.so.575.57.08: pattern libnvidia-vulkan-producer.so.575.57.08 not found
64-bit library libnvidia-vulkan-producer.so.575.57.08: not found 
WARN[0000] Could not locate nvidia_drv.so: pattern nvidia_drv.so not found 
WARN[0000] Could not locate libglxserver_nvidia.so.575.57.08: pattern libglxserver_nvidia.so.575.57.08 not found 
INFO[0000] Generated CDI spec with version 0.8.0        
root@nvidia-container-toolkit-1-16-2:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all busybox
e6ccdf9ba31b4937983d12b89d99f60e7a074c7a8a940e9b735f7c4d3ef0f483
root@nvidia-container-toolkit-1-16-2:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/e6ccdf9ba31b4937983d12b89d99f60e7a074c7a8a940e9b735f7c4d3ef0f483/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/proc/430/exe",
      "args": [
        "libnetwork-setkey",
        "-exec-root=/var/run/docker",
        "e6ccdf9ba31b4937983d12b89d99f60e7a074c7a8a940e9b735f7c4d3ef0f483",
        "847b4e30ee7a"
      ],
      "env": [
        "TRACEPARENT=00-bb07dbcdf05b8b37e71446dc23a32615-afc4877ad11510f4-01"
      ]
    }
  ],
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "update-ldcache",
        "--folder",
        "/usr/lib/x86_64-linux-gnu"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
root@nvidia-container-toolkit-1-16-2:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-16-2:~# lsmod |grep fake
fake_nvidia_driver     12288  0
root@nvidia-container-toolkit-1-16-2:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 25 08:28 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-16-2:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; preset: enabled)
     Active: inactive (dead) since Fri 2025-07-25 11:01:15 UTC; 2min 28s ago
    Process: 618 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 618 (code=exited, status=0/SUCCESS)
        CPU: 20ms

Jul 25 11:01:15 nvidia-container-toolkit-1-16-2 systemd[1]: Starting fake-nvidia-mknod.service - Create device nodes for fake nvidia driver...
Jul 25 11:01:15 nvidia-container-toolkit-1-16-2 systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 25 11:01:15 nvidia-container-toolkit-1-16-2 systemd[1]: Finished fake-nvidia-mknod.service - Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-16-2:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.16.2
commit: a5a5833c14a15fd9c86bcece85d5ec6621b65652
root@nvidia-container-toolkit-1-16-2:~# docker info
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
  Running: 1
  Paused: 0
  Stopped: 0
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
 Name: nvidia-container-toolkit-1-16-2
 ID: 17e9631d-4047-434a-9048-e910670fef3c
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
make all DIR=nvidia-container-toolkit/v1.16.2
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.16.2_v0.3.0
```
