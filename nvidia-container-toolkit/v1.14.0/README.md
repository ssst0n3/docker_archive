# nvidia-container-toolkit v1.14.0

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.14.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0_v0.9.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0_v0.9.0: install real nvidia driver without kernel module; install i386 libs; bump fake-nvidia to v0.7.2
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0_v0.2.0: bump fake-nvidia to v0.7.1
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
6bfa440bb962e191163472992a9ecdd7aa865df7a9b29b60e41ebad93cb747fd
root@nvidia-container-toolkit-1-14-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/6bfa440bb962e191163472992a9ecdd7aa865df7a9b29b60e41ebad93cb747fd/config.json | jq .hooks
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
      "path": "/proc/314/exe",
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
WARN[0000] Ignoring 32-bit libraries for libcuda.so: [/lib/i386-linux-gnu/libcuda.so.575.57.08] 
INFO[0000] Using driver version 575.57.08               
WARN[0000] Ignoring 32-bit libraries for libcuda.so: [/lib/i386-linux-gnu/libcuda.so.575.57.08] 
INFO[0000] Selecting /dev/nvidia-modeset as /dev/nvidia-modeset 
WARN[0000] Could not locate /dev/nvidia-uvm-tools: pattern /dev/nvidia-uvm-tools not found 
WARN[0000] Could not locate /dev/nvidia-uvm: pattern /dev/nvidia-uvm not found 
INFO[0000] Selecting /dev/nvidiactl as /dev/nvidiactl   
WARN[0000] Ignoring 32-bit libraries for libnvidia-egl-gbm.so: [/lib/i386-linux-gnu/libnvidia-egl-gbm.so.1.1.2] 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1.1.2 as /lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1.1.2 
INFO[0000] Selecting /usr/share/glvnd/egl_vendor.d/10_nvidia.json as /usr/share/glvnd/egl_vendor.d/10_nvidia.json 
INFO[0000] Selecting /etc/vulkan/icd.d/nvidia_icd.json as /etc/vulkan/icd.d/nvidia_icd.json 
INFO[0000] Selecting /etc/vulkan/implicit_layer.d/nvidia_layers.json as /etc/vulkan/implicit_layer.d/nvidia_layers.json 
INFO[0000] Selecting /usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json as /usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json 
INFO[0000] Selecting /usr/share/egl/egl_external_platform.d/10_nvidia_wayland.json as /usr/share/egl/egl_external_platform.d/10_nvidia_wayland.json 
WARN[0000] Could not locate nvidia/xorg/nvidia_drv.so: pattern nvidia/xorg/nvidia_drv.so not found 
WARN[0000] Could not locate nvidia/xorg/libglxserver_nvidia.so.575.57.08: pattern nvidia/xorg/libglxserver_nvidia.so.575.57.08 not found 
WARN[0000] Could not locate X11/xorg.conf.d/10-nvidia.conf: pattern X11/xorg.conf.d/10-nvidia.conf not found 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libcuda.so.575.57.08 as /lib/x86_64-linux-gnu/libcuda.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 as /lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 as /lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 as /lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 
WARN[0000] Could not locate /nvidia-persistenced/socket: pattern /nvidia-persistenced/socket not found 
WARN[0000] Could not locate /nvidia-fabricmanager/socket: pattern /nvidia-fabricmanager/socket not found 
WARN[0000] Could not locate /tmp/nvidia-mps: pattern /tmp/nvidia-mps not found 
INFO[0000] Selecting /lib/firmware/nvidia/575.57.08/gsp_ga10x.bin as /lib/firmware/nvidia/575.57.08/gsp_ga10x.bin 
INFO[0000] Selecting /lib/firmware/nvidia/575.57.08/gsp_tu10x.bin as /lib/firmware/nvidia/575.57.08/gsp_tu10x.bin 
INFO[0000] Selecting /usr/bin/nvidia-smi as /usr/bin/nvidia-smi 
INFO[0000] Selecting /usr/bin/nvidia-debugdump as /usr/bin/nvidia-debugdump 
INFO[0000] Selecting /usr/bin/nvidia-persistenced as /usr/bin/nvidia-persistenced 
INFO[0000] Selecting /usr/bin/nvidia-cuda-mps-control as /usr/bin/nvidia-cuda-mps-control 
INFO[0000] Selecting /usr/bin/nvidia-cuda-mps-server as /usr/bin/nvidia-cuda-mps-server 
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
09f7d863616dc78cdd41a64317887c22b93da91f44832ccb8125e349a89c3217
root@nvidia-container-toolkit-1-14-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/09f7d863616dc78cdd41a64317887c22b93da91f44832ccb8125e349a89c3217/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/proc/314/exe",
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
root@nvidia-container-toolkit-1-14-0:~# ls -lah /usr/lib/x86_64-linux-gnu/libnvidia-ml.so*
lrwxrwxrwx 1 root root  43 Jul 31 02:37 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
lrwxrwxrwx 1 root root  51 Jul 31 02:37 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
-rwxr-xr-x 1 root root 22K Jul 31 02:37 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
root@nvidia-container-toolkit-1-14-0:~# systemctl status fake-nvidia-device
○ fake-nvidia-device.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-device.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Thu 2025-07-31 03:01:11 UTC; 4min 50s ago
    Process: 465 ExecStart=/usr/local/bin/fake-nvidia-device.sh (code=exited, status=0/SUCCESS)
   Main PID: 465 (code=exited, status=0/SUCCESS)
        CPU: 6ms

Jul 31 03:01:11 nvidia-container-toolkit-1-14-0 systemd[1]: Starting Create device nodes for fake nvidia driver...
Jul 31 03:01:11 nvidia-container-toolkit-1-14-0 systemd[1]: fake-nvidia-device.service: Deactivated successfully.
Jul 31 03:01:11 nvidia-container-toolkit-1-14-0 systemd[1]: Finished Create device nodes for fake nvidia driver.
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
 Runtimes: io.containerd.runc.v2 nvidia runc
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
 Kernel Version: 5.15.0-151-generic
 Operating System: Ubuntu 22.04.5 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.918GiB
 Name: nvidia-container-toolkit-1-14-0
 ID: 3851f7b6-a74b-4ad3-a986-21bdc38e8506
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
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.14.0_v0.9.0
```
