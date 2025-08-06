# nvidia-container-toolkit v1.17.6 with podman v5.5.1

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6_podman-v5.5.1_v0.1.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6_podman-v5.5.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6_podman-v5.5.1_v0.1.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6_podman-v5.5.1_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.17.6_podman-v5.5.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

### CDI mode

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.17.6/cdi-support.html

```shell
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
INFO[0000] Using /usr/lib64/libnvidia-ml.so.575.57.08   
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
INFO[0000] Selecting /dev/nvidia-modeset as /dev/nvidia-modeset 
WARN[0000] Could not locate /dev/nvidia-uvm-tools: pattern /dev/nvidia-uvm-tools not found 
WARN[0000] Could not locate /dev/nvidia-uvm: pattern /dev/nvidia-uvm not found 
INFO[0000] Selecting /dev/nvidiactl as /dev/nvidiactl   
INFO[0000] Selecting /usr/lib64/libnvidia-egl-gbm.so.1.1.2 as /usr/lib64/libnvidia-egl-gbm.so.1.1.2 
INFO[0000] Selecting /usr/lib64/libnvidia-egl-wayland.so.1.1.19 as /usr/lib64/libnvidia-egl-wayland.so.1.1.19 
INFO[0000] Selecting /usr/lib64/libnvidia-allocator.so.575.57.08 as /usr/lib64/libnvidia-allocator.so.575.57.08 
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
INFO[0000] Selecting /usr/lib64/libEGL_nvidia.so.575.57.08 as /usr/lib64/libEGL_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libGLESv1_CM_nvidia.so.575.57.08 as /usr/lib64/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libGLESv2_nvidia.so.575.57.08 as /usr/lib64/libGLESv2_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libGLX_nvidia.so.575.57.08 as /usr/lib64/libGLX_nvidia.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libcuda.so.575.57.08 as /usr/lib64/libcuda.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libcudadebugger.so.575.57.08 as /usr/lib64/libcudadebugger.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvcuvid.so.575.57.08 as /usr/lib64/libnvcuvid.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-allocator.so.575.57.08 as /usr/lib64/libnvidia-allocator.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-cfg.so.575.57.08 as /usr/lib64/libnvidia-cfg.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-eglcore.so.575.57.08 as /usr/lib64/libnvidia-eglcore.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-encode.so.575.57.08 as /usr/lib64/libnvidia-encode.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-fbc.so.575.57.08 as /usr/lib64/libnvidia-fbc.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-glcore.so.575.57.08 as /usr/lib64/libnvidia-glcore.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-glsi.so.575.57.08 as /usr/lib64/libnvidia-glsi.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-glvkspirv.so.575.57.08 as /usr/lib64/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-gpucomp.so.575.57.08 as /usr/lib64/libnvidia-gpucomp.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-gtk2.so.575.57.08 as /usr/lib64/libnvidia-gtk2.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-gtk3.so.575.57.08 as /usr/lib64/libnvidia-gtk3.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-ml.so.575.57.08 as /usr/lib64/libnvidia-ml.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-ngx.so.575.57.08 as /usr/lib64/libnvidia-ngx.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-nvvm.so.575.57.08 as /usr/lib64/libnvidia-nvvm.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-opencl.so.575.57.08 as /usr/lib64/libnvidia-opencl.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-opticalflow.so.575.57.08 as /usr/lib64/libnvidia-opticalflow.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-pkcs11-openssl3.so.575.57.08 as /usr/lib64/libnvidia-pkcs11-openssl3.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-pkcs11.so.575.57.08 as /usr/lib64/libnvidia-pkcs11.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-present.so.575.57.08 as /usr/lib64/libnvidia-present.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-ptxjitcompiler.so.575.57.08 as /usr/lib64/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-rtcore.so.575.57.08 as /usr/lib64/libnvidia-rtcore.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-sandboxutils.so.575.57.08 as /usr/lib64/libnvidia-sandboxutils.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-tls.so.575.57.08 as /usr/lib64/libnvidia-tls.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-vksc-core.so.575.57.08 as /usr/lib64/libnvidia-vksc-core.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvidia-wayland-client.so.575.57.08 as /usr/lib64/libnvidia-wayland-client.so.575.57.08 
INFO[0000] Selecting /usr/lib64/libnvoptix.so.575.57.08 as /usr/lib64/libnvoptix.so.575.57.08 
INFO[0000] Selecting /usr/lib64/vdpau/libvdpau_nvidia.so.575.57.08 as /usr/lib64/vdpau/libvdpau_nvidia.so.575.57.08 
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
WARN[0000] Could not locate nvidia-imex: pattern nvidia-imex not found 
WARN[0000] Could not locate nvidia-imex-ctl: pattern nvidia-imex-ctl not found 
INFO[0000] Generated CDI spec with version 0.8.0    
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# nvidia-ctk cdi list
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
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# podman run -tid --device nvidia.com/gpu=all busybox
Resolved "busybox" as an alias (/etc/containers/registries.conf.d/000-shortnames.conf)
Trying to pull docker.io/library/busybox:latest...
Getting image source signatures
Copying blob 90b9666d4aed done   | 
Copying config 6d3e4188a3 done   | 
Writing manifest to image destination
d565e59d408f7df5b95e849eb57c16270575b64209fea89312af3e7af995f1a6
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# cat /run/crun/d565e59d408f7df5b95e849eb57c16270575b64209fea89312af3e7af995f1a6/config.json | jq .hooks
{
  "createContainer": [
    {
      "path": "/usr/bin/nvidia-cdi-hook",
      "args": [
        "nvidia-cdi-hook",
        "create-symlinks",
        "--link",
        "../libnvidia-allocator.so.1::/usr/lib64/gbm/nvidia-drm_gbm.so",
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
        "libGLX_nvidia.so.575.57.08::/usr/lib64/libGLX_indirect.so.0",
        "--link",
        "libnvidia-opticalflow.so.1::/usr/lib64/libnvidia-opticalflow.so",
        "--link",
        "libcuda.so.1::/usr/lib64/libcuda.so"
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
        "/usr/lib64",
        "--folder",
        "/usr/lib64/vdpau"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# nvidia-container-cli info
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
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# lsmod |grep fake
fake_nvidia_driver     12288  0
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# ls -lah /usr/lib64/libnvidia-ml.so*
lrwxrwxrwx 1 root root  31 Aug  6 02:47 /usr/lib64/libnvidia-ml.so -> /usr/../lib64/libnvidia-ml.so.1
lrwxrwxrwx 1 root root  39 Aug  6 02:47 /usr/lib64/libnvidia-ml.so.1 -> /usr/../lib64/libnvidia-ml.so.575.57.08
-rwxr-xr-x 1 root root 22K Aug  6 02:47 /usr/lib64/libnvidia-ml.so.575.57.08
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# systemctl status fake-nvidia-device
○ fake-nvidia-device.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-device.service; enabled; preset: disabled)
     Active: inactive (dead) since Wed 2025-08-06 02:51:13 UTC; 1min 36s ago
    Process: 597 ExecStart=/usr/local/bin/fake-nvidia-device.sh (code=exited, status=0/SUCCESS)
   Main PID: 597 (code=exited, status=0/SUCCESS)
        CPU: 6ms

Aug 06 02:51:13 nvidia-container-toolkit-1-17-6-podman-5-5-1 systemd[1]: Starting Create device nodes for fake nvidia driver...
Aug 06 02:51:13 nvidia-container-toolkit-1-17-6-podman-5-5-1 systemd[1]: fake-nvidia-device.service: Deactivated successfully.
Aug 06 02:51:13 nvidia-container-toolkit-1-17-6-podman-5-5-1 systemd[1]: Finished Create device nodes for fake nvidia driver.
```

### environment details

```shell
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.6
commit: e627eb2e21e167988e04c0579a1c941c1e263ff6
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# crun --version
crun version 1.22
commit: 4de19b63a85efd9ea8503452179c371181750130
rundir: /run/user/0/crun
spec: 1.0.0
+SYSTEMD +SELINUX +APPARMOR +CAP +SECCOMP +EBPF +CRIU +YAJL
[root@nvidia-container-toolkit-1-17-6-podman-5-5-1 ~]# podman info
host:
  arch: amd64
  buildahVersion: 1.40.1
  cgroupControllers:
  - cpuset
  - cpu
  - io
  - memory
  - hugetlb
  - pids
  - rdma
  - misc
  cgroupManager: systemd
  cgroupVersion: v2
  conmon:
    package: conmon-2.1.13-1.el9.x86_64
    path: /usr/bin/conmon
    version: 'conmon version 2.1.13, commit: 52f60d65890dbb8430d05c22545c0d4f96d0f4db'
  cpuUtilization:
    idlePercent: 98.63
    systemPercent: 0.87
    userPercent: 0.51
  cpus: 2
  databaseBackend: sqlite
  distribution:
    distribution: centos
    version: "9"
  eventLogger: journald
  freeLocks: 2047
  hostname: nvidia-container-toolkit-1-17-6-podman-5-5-1
  idMappings:
    gidmap: null
    uidmap: null
  kernel: 5.14.0-601.el9.x86_64
  linkmode: dynamic
  logDriver: journald
  memFree: 1701281792
  memTotal: 2058506240
  networkBackend: netavark
  networkBackendInfo:
    backend: netavark
    dns:
      package: aardvark-dns-1.15.0-1.el9.x86_64
      path: /usr/libexec/podman/aardvark-dns
      version: aardvark-dns 1.15.0
    package: netavark-1.15.1-1.el9.x86_64
    path: /usr/libexec/podman/netavark
    version: netavark 1.15.1
  ociRuntime:
    name: crun
    package: crun-1.22-1.el9.x86_64
    path: /usr/bin/crun
    version: |-
      crun version 1.22
      commit: 4de19b63a85efd9ea8503452179c371181750130
      rundir: /run/user/0/crun
      spec: 1.0.0
      +SYSTEMD +SELINUX +APPARMOR +CAP +SECCOMP +EBPF +CRIU +YAJL
  os: linux
  pasta:
    executable: /usr/bin/pasta
    package: passt-0^20250415.g8ec1341-1.el9.x86_64
    version: ""
  remoteSocket:
    exists: true
    path: /run/podman/podman.sock
  rootlessNetworkCmd: pasta
  security:
    apparmorEnabled: false
    capabilities: CAP_CHOWN,CAP_DAC_OVERRIDE,CAP_FOWNER,CAP_FSETID,CAP_KILL,CAP_NET_BIND_SERVICE,CAP_SETFCAP,CAP_SETGID,CAP_SETPCAP,CAP_SETUID,CAP_SYS_CHROOT
    rootless: false
    seccompEnabled: true
    seccompProfilePath: /usr/share/containers/seccomp.json
    selinuxEnabled: false
  serviceIsRemote: false
  slirp4netns:
    executable: /usr/bin/slirp4netns
    package: slirp4netns-1.3.3-1.el9.x86_64
    version: |-
      slirp4netns version 1.3.3
      commit: 944fa94090e1fd1312232cbc0e6b43585553d824
      libslirp: 4.4.0
      SLIRP_CONFIG_VERSION_MAX: 3
      libseccomp: 2.5.2
  swapFree: 0
  swapTotal: 0
  uptime: 0h 2m 3.00s
  variant: ""
plugins:
  authorization: null
  log:
  - k8s-file
  - none
  - passthrough
  - journald
  network:
  - bridge
  - macvlan
  - ipvlan
  volume:
  - local
registries:
  search:
  - registry.access.redhat.com
  - registry.redhat.io
  - docker.io
store:
  configFile: /etc/containers/storage.conf
  containerStore:
    number: 1
    paused: 0
    running: 1
    stopped: 0
  graphDriverName: overlay
  graphOptions:
    overlay.mountopt: nodev,metacopy=on
  graphRoot: /var/lib/containers/storage
  graphRootAllocated: 10462973952
  graphRootUsed: 3403890688
  graphStatus:
    Backing Filesystem: extfs
    Native Overlay Diff: "false"
    Supports d_type: "true"
    Supports shifting: "true"
    Supports volatile: "true"
    Using metacopy: "true"
  imageCopyTmpDir: /var/tmp
  imageStore:
    number: 1
  runRoot: /run/containers/storage
  transientStore: false
  volumePath: /var/lib/containers/storage/volumes
version:
  APIVersion: 5.5.1
  Built: 1749565945
  BuiltTime: Tue Jun 10 14:32:25 2025
  GitCommit: ""
  GoVersion: go1.24.3 (Red Hat 1.24.3-3.el9)
  Os: linux
  OsArch: linux/amd64
  Version: 5.5.1
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.17.6_podman-v5.5.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6_podman-v5.5.1_v0.1.0
```
