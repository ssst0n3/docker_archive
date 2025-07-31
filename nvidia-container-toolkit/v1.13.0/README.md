# nvidia-container-toolkit v1.13.0

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.13.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0_v0.9.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0_v0.9.0: install real nvidia driver without kernel module; install i386 libs; bump fake-nvidia to v0.7.2
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0_v0.2.0: bump fake-nvidia to v0.7.1
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
671f50925b4c9e1f360a70918f3be2d028d34a6a32130148446dfc803f99c0ff
root@nvidia-container-toolkit-1-13-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/671f50925b4c9e1f360a70918f3be2d028d34a6a32130148446dfc803f99c0ff/config.json | jq .hooks
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
      "path": "/proc/312/exe",
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
WARN[0000] Ignoring 32-bit libraries for libcuda.so: [/lib/i386-linux-gnu/libcuda.so.575.57.08 /lib/i386-linux-gnu/libcuda.so.1] 
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
INFO[0000] Generated CDI spec with version 0.5.0    
root@nvidia-container-toolkit-1-13-0:~# grep "  name:" /etc/cdi/nvidia.yaml
  name: "0"
  name: "1"
  name: "2"
  name: "3"
  name: all
root@nvidia-container-toolkit-1-13-0:~# sed -i s/auto/cdi/g /etc/nvidia-container-runtime/config.toml
root@nvidia-container-toolkit-1-13-0:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all busybox
cd7bd17837b1434f8729c25fb95bd743a7d6d4407beb668a105746823e365941
docker: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error running hook #0: error running hook: exit status 1, stdout: , stderr: time="2025-07-31T02:44:37Z" level=error msg="failed to update ld.so.conf: failed to create config file: open /var/lib/docker/overlay2/56ce37c38c3b73e917ecc4a82a5d8b051541985b23d4e065a5d875a4181796ff/merged/etc/ld.so.conf.d/nvcr-2698165039.conf: no such file or directory": unknown.
root@nvidia-container-toolkit-1-13-0:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all ubuntu
cd7bd17837b1434f8729c25fb95bd743a7d6d4407beb668a105746823e365941
root@nvidia-container-toolkit-1-13-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/2d2c1dd8ee5aea225c10bab84cb4291ee3283d323f98e96bcc843706741b94a2/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/proc/312/exe",
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
root@nvidia-container-toolkit-1-13-0:~# ls -lah /usr/lib/x86_64-linux-gnu/libnvidia-ml.so*
lrwxrwxrwx 1 root root  43 Jul 31 02:33 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
lrwxrwxrwx 1 root root  51 Jul 31 02:33 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
-rwxr-xr-x 1 root root 22K Jul 31 02:33 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
root@nvidia-container-toolkit-1-13-0:~# systemctl status fake-nvidia-device
○ fake-nvidia-device.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-device.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Thu 2025-07-31 02:40:27 UTC; 5min ago
    Process: 462 ExecStart=/usr/local/bin/fake-nvidia-device.sh (code=exited, status=0/SUCCESS)
   Main PID: 462 (code=exited, status=0/SUCCESS)
        CPU: 7ms

Jul 31 02:40:27 nvidia-container-toolkit-1-13-0 systemd[1]: Starting Create device nodes for fake nvidia driver...
Jul 31 02:40:27 nvidia-container-toolkit-1-13-0 systemd[1]: fake-nvidia-device.service: Deactivated successfully.
Jul 31 02:40:27 nvidia-container-toolkit-1-13-0 systemd[1]: Finished Create device nodes for fake nvidia driver.
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
 Containers: 3
  Running: 2
  Paused: 0
  Stopped: 1
 Images: 2
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
 Kernel Version: 5.15.0-151-generic
 Operating System: Ubuntu 22.04.5 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.918GiB
 Name: nvidia-container-toolkit-1-13-0
 ID: 7069e519-b829-494c-8faa-8322b1bfd2c9
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
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.13.0_v0.9.0
```
