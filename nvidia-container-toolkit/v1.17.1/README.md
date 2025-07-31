# nvidia-container-toolkit v1.17.1

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.1 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.1_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.1_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.1_v0.3.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.1_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.1 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.1_v0.9.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.1_v0.9.0: install real nvidia driver without kernel module; install i386 libs; bump fake-nvidia to v0.7.2
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.1_v0.3.0: bump fake-nvidia to v0.7.1
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.1_v0.2.0: CDI compatible
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.1_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.17.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-17-1:~# docker run -tid --runtime=nvidia --gpus=all busybox
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
90b9666d4aed: Pull complete 
Digest: sha256:f9a104fddb33220ec80fc45a4e606c74aadf1ef7a3832eb0b05be9e90cd61f5f
Status: Downloaded newer image for busybox:latest
bf6ad1042c5b2924e05664b5a8cce18947310629402eef0e3c6da2cb87380b0d
root@nvidia-container-toolkit-1-17-1:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/bf6ad1042c5b2924e05664b5a8cce18947310629402eef0e3c6da2cb87380b0d/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/usr/bin/nvidia-container-runtime-hook",
      "args": [
        "nvidia-container-runtime-hook",
        "prestart"
      ],
      "env": [
        "LANG=C.UTF-8",
        "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin",
        "NOTIFY_SOCKET=/run/systemd/notify",
        "USER=root",
        "INVOCATION_ID=ff24229e80fa4448a45c5a020637e45f",
        "JOURNAL_STREAM=8:5049",
        "SYSTEMD_EXEC_PID=434",
        "MEMORY_PRESSURE_WATCH=/sys/fs/cgroup/system.slice/docker.service/memory.pressure",
        "MEMORY_PRESSURE_WRITE=c29tZSAyMDAwMDAgMjAwMDAwMAA=",
        "OTEL_SERVICE_NAME=dockerd",
        "OTEL_EXPORTER_OTLP_TRACES_PROTOCOL=http/protobuf",
        "OTEL_EXPORTER_OTLP_METRICS_PROTOCOL=http/protobuf",
        "TMPDIR=/var/lib/docker/tmp"
      ]
    },
    {
      "path": "/proc/434/exe",
      "args": [
        "libnetwork-setkey",
        "-exec-root=/var/run/docker",
        "bf6ad1042c5b2924e05664b5a8cce18947310629402eef0e3c6da2cb87380b0d",
        "d198bd4b1702"
      ],
      "env": [
        "TRACEPARENT=00-bfc56bb26b92fa715c9cb3acd0ad68c3-d1ec67c893ec3237-01"
      ]
    }
  ]
}
```

### CDI mode

```shell
root@nvidia-container-toolkit-1-17-1:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
INFO[0000] Using /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] Using /usr/lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 
INFO[0000] Auto-detected mode as 'nvml'                 
ERROR: Couldn't load symbol: /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08: undefined symbol: nvmlDeviceGetHandleByUUID
ERROR: init 243 result=6WARN[0000] Failed to init nvsandboxutils: ERROR_LIBRARY_LOAD; ignoring 
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
INFO[0000] Selecting /dev/nvidia-modeset as /dev/nvidia-modeset 
WARN[0000] Could not locate /dev/nvidia-uvm-tools: pattern /dev/nvidia-uvm-tools not found 
WARN[0000] Could not locate /dev/nvidia-uvm: pattern /dev/nvidia-uvm not found 
INFO[0000] Selecting /dev/nvidiactl as /dev/nvidiactl   
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1.1.2 as /usr/lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1.1.2 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-egl-wayland.so.1.1.19 as /usr/lib/x86_64-linux-gnu/libnvidia-egl-wayland.so.1.1.19 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 
WARN[0000] Could not locate libnvidia-vulkan-producer.so.575.57.08: pattern libnvidia-vulkan-producer.so.575.57.08 not found
libnvidia-vulkan-producer.so.575.57.08: not found 
INFO[0000] Selecting /usr/lib64/xorg/modules/drivers/nvidia_drv.so as /usr/lib64/xorg/modules/drivers/nvidia_drv.so 
INFO[0000] Selecting /usr/lib64/xorg/modules/extensions/libglxserver_nvidia.so.575.57.08 as /usr/lib64/xorg/modules/extensions/libglxserver_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/share/glvnd/egl_vendor.d/10_nvidia.json as /usr/share/glvnd/egl_vendor.d/10_nvidia.json 
INFO[0000] Selecting /usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json as /usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json 
INFO[0000] Selecting /usr/share/egl/egl_external_platform.d/10_nvidia_wayland.json as /usr/share/egl/egl_external_platform.d/10_nvidia_wayland.json 
INFO[0000] Selecting /usr/share/nvidia/nvoptix.bin as /usr/share/nvidia/nvoptix.bin 
WARN[0000] Could not locate X11/xorg.conf.d/10-nvidia.conf: pattern X11/xorg.conf.d/10-nvidia.conf not found 
WARN[0000] Could not locate X11/xorg.conf.d/nvidia-drm-outputclass.conf: pattern X11/xorg.conf.d/nvidia-drm-outputclass.conf not found 
INFO[0000] Selecting /etc/vulkan/icd.d/nvidia_icd.json as /etc/vulkan/icd.d/nvidia_icd.json 
WARN[0000] Could not locate vulkan/icd.d/nvidia_layers.json: pattern vulkan/icd.d/nvidia_layers.json not found
pattern vulkan/icd.d/nvidia_layers.json not found 
INFO[0000] Selecting /etc/vulkan/implicit_layer.d/nvidia_layers.json as /etc/vulkan/implicit_layer.d/nvidia_layers.json 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libcuda.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libcuda.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 as /usr/lib/x86_64-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 
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
INFO[0000] Generated CDI spec with version 0.8.0        
root@nvidia-container-toolkit-1-17-1:~# nvidia-ctk cdi list
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
root@nvidia-container-toolkit-1-17-1:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all busybox
9e40bd254c068a02fe24d8331a69d7db0c5cf2ac4e9c37a6f87f68ee39d68ee5
root@nvidia-container-toolkit-1-17-1:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/9e40bd254c068a02fe24d8331a69d7db0c5cf2ac4e9c37a6f87f68ee39d68ee5/config.json | jq .hooks
{
  "prestart": [
    {
      "path": "/proc/434/exe",
      "args": [
        "libnetwork-setkey",
        "-exec-root=/var/run/docker",
        "9e40bd254c068a02fe24d8331a69d7db0c5cf2ac4e9c37a6f87f68ee39d68ee5",
        "d198bd4b1702"
      ],
      "env": [
        "TRACEPARENT=00-0b547f8c1225d0fbe2c9988c1287ebdd-392d86aaf59f745a-01"
      ]
    }
  ],
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "create-symlinks",
        "--link",
        "../libnvidia-allocator.so.1::/usr/lib/x86_64-linux-gnu/gbm/nvidia-drm_gbm.so",
        "--link",
        "libglxserver_nvidia.so.575.57.08::/usr/lib64/xorg/modules/extensions/libglxserver_nvidia.so"
      ]
    },
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "create-symlinks",
        "--link",
        "libGLX_nvidia.so.575.57.08::/usr/lib/x86_64-linux-gnu/libGLX_indirect.so.0",
        "--link",
        "libnvidia-opticalflow.so.1::/usr/lib/x86_64-linux-gnu/libnvidia-opticalflow.so",
        "--link",
        "libcuda.so.1::/usr/lib/x86_64-linux-gnu/libcuda.so"
      ]
    },
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "update-ldcache",
        "--folder",
        "/usr/lib/x86_64-linux-gnu",
        "--folder",
        "/usr/lib/x86_64-linux-gnu/vdpau"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
root@nvidia-container-toolkit-1-17-1:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-17-1:~# lsmod |grep fake
fake_nvidia_driver     12288  0
root@nvidia-container-toolkit-1-17-1:~# ls -lah /usr/lib/x86_64-linux-gnu/libnvidia-ml.so*
lrwxrwxrwx 1 root root  43 Jul 31 03:37 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
lrwxrwxrwx 1 root root  51 Jul 31 03:37 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
-rwxr-xr-x 1 root root 22K Jul 31 03:37 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
root@nvidia-container-toolkit-1-17-1:~# systemctl status fake-nvidia-device
○ fake-nvidia-device.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-device.service; enabled; preset: enabled)
     Active: inactive (dead) since Thu 2025-07-31 07:00:49 UTC; 3min 13s ago
    Process: 621 ExecStart=/usr/local/bin/fake-nvidia-device.sh (code=exited, status=0/SUCCESS)
   Main PID: 621 (code=exited, status=0/SUCCESS)
        CPU: 7ms

Jul 31 07:00:49 nvidia-container-toolkit-1-17-1 systemd[1]: Starting fake-nvidia-device.service - Create device nodes for fake nvidia driver...
Jul 31 07:00:49 nvidia-container-toolkit-1-17-1 systemd[1]: fake-nvidia-device.service: Deactivated successfully.
Jul 31 07:00:49 nvidia-container-toolkit-1-17-1 systemd[1]: Finished fake-nvidia-device.service - Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-17-1:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.1
commit: 1467f3f339a855f20d179e9883e418a09118a93e
root@nvidia-container-toolkit-1-17-1:~# docker info
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
 Containers: 2
  Running: 2
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
 Runtimes: runc io.containerd.runc.v2 nvidia
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
 Kernel Version: 6.8.0-71-generic
 Operating System: Ubuntu 24.04.2 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.922GiB
 Name: nvidia-container-toolkit-1-17-1
 ID: b8c20923-af5b-4d71-a3e6-f7296f73cde4
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

WARNING: bridge-nf-call-iptables is disabled
WARNING: bridge-nf-call-ip6tables is disabled
root@nvidia-container-toolkit-1-17-1:~# containerd --version
containerd containerd.io 1.7.22 7f7fdf5fed64eb6a7caf99b3e12efcf9d60e311c
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.17.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.1_v0.9.0
```
