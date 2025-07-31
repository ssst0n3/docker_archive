# nvidia-container-toolkit v1.12.0

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.12.0 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.12.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.12.0_v0.9.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.12.0_v0.2.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.12.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.12.0 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.12.0_v0.9.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.12.0_v0.9.0: install real nvidia driver without kernel module; install i386 libs; bump fake-nvidia to v0.7.2
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.12.0_v0.2.0: bump fake-nvidia to v0.7.1
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.12.0_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.12.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
$ ./ssh
```

https://web.archive.org/web/20230627162323/https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

### default mode(legacy)

```shell
root@nvidia-container-toolkit-1-12-0:~# docker run -tid --runtime=nvidia --gpus=all busybox
36ae65e763ef0c38065ebba48adbfa3750bc3d1c671a7e0fe3f2a529e14d61ba
root@nvidia-container-toolkit-1-12-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/36ae65e763ef0c38065ebba48adbfa3750bc3d1c671a7e0fe3f2a529e14d61ba/config.json | jq .hooks
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

The `l.logger` field in v1.12.0, which was left uninitialized and could cause a panic, was fixed in [v1.13.0-rc.3](https://github.com/NVIDIA/nvidia-container-toolkit/commit/b2aaa21b0a1a4a9631f58bdd44bb678e15093b15).

https://github.com/NVIDIA/nvidia-container-toolkit/blob/v1.12.0/internal/lookup/library.go#L36-L68

```
func NewLibraryLocator(logger *log.Logger, root string) (Locator, error) {
	...
	l := library{
		symlink: NewSymlinkLocator(logger, root),
		cache:   cache,
	}

	return &l, nil
}

// Locate finds the specified libraryname.
// If the input is a library name, the ldcache is searched otherwise the
// provided path is resolved as a symlink.
func (l library) Locate(libname string) ([]string, error) {
	...
	paths32, paths64 := l.cache.Lookup(libname)
	if len(paths32) > 0 {
		l.logger.Warnf("Ignoring 32-bit libraries for %v: %v", libname, paths32)
	}
  ...
}
```

```shell
root@nvidia-container-toolkit-1-12-0:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
WARN[0000] Failed to locate : pattern  not found        
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
WARN[0000] Could not locate /var/run/nvidia-persistenced/socket: pattern /var/run/nvidia-persistenced/socket not found 
WARN[0000] Could not locate /var/run/nvidia-fabricmanager/socket: pattern /var/run/nvidia-fabricmanager/socket not found 
WARN[0000] Could not locate /tmp/nvidia-mps: pattern /tmp/nvidia-mps not found 
INFO[0000] Using driver version 575.57.08               
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] found 64-bit driver lib: /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libcuda.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libcuda.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libEGL_nvidia.so.575.57.08 
INFO[0000] Selecting /dev/nvidia-modeset as /dev/nvidia-modeset 
WARN[0000] Could not locate /dev/nvidia-uvm-tools: pattern /dev/nvidia-uvm-tools not found 
WARN[0000] Could not locate /dev/nvidia-uvm: pattern /dev/nvidia-uvm not found 
INFO[0000] Selecting /dev/nvidiactl as /dev/nvidiactl   
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x2c pc=0x512482]

goroutine 1 [running]:
github.com/sirupsen/logrus.(*Logger).Logf(0xc00019fa30?, 0x1?, {0x6afab6?, 0x1?}, {0xc00010e868?, 0x203000?, 0x203000?})
	/go/src/nvidia-container-toolkit/vendor/github.com/sirupsen/logrus/logger.go:152 +0x22
github.com/sirupsen/logrus.(*Logger).Warnf(...)
	/go/src/nvidia-container-toolkit/vendor/github.com/sirupsen/logrus/logger.go:178
github.com/NVIDIA/nvidia-container-toolkit/internal/lookup.library.Locate({0x0, {0x6fd1f8, 0xc000080870}, {0x6fd7a0, 0xc0000cd540}}, {0x6a8592, 0x14})
	/go/src/nvidia-container-toolkit/internal/lookup/library.go:60 +0x1ab
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.(*mounts).Mounts(0xc00009e9c0)
	/go/src/nvidia-container-toolkit/internal/discover/mounts.go:71 +0x52b
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.list.Mounts({{0xc0000c8dc0?, 0xc0001ae080?, 0xc00010ee78?}})
	/go/src/nvidia-container-toolkit/internal/discover/list.go:59 +0xa9
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.list.Mounts({{0xc0001a90b0?, 0xc0001ae0c0?, 0x2?}})
	/go/src/nvidia-container-toolkit/internal/discover/list.go:59 +0xa9
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.list.Mounts({{0xc0000c8e80?, 0xc000080aa0?, 0xe7f2216700000100?}})
	/go/src/nvidia-container-toolkit/internal/discover/list.go:59 +0xa9
github.com/NVIDIA/nvidia-container-toolkit/internal/edits.FromDiscoverer({0x6fdc10, 0xc0000aabb8})
	/go/src/nvidia-container-toolkit/internal/edits/edits.go:57 +0xc2
github.com/NVIDIA/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate.command.generateSpec({0x69c8b6?}, {0x0, 0x0}, {0x6a781f, 0x13}, {0x6fda48, 0xc0000c8880})
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate/generate.go:263 +0xdaa
github.com/NVIDIA/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate.command.run({0x69bbb6?}, 0xc0000cd4f0?, 0xc000080460)
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate/generate.go:134 +0x13f
github.com/NVIDIA/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate.command.build.func2(0xc0000cd4a0?)
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate/generate.go:74 +0x27
github.com/urfave/cli/v2.(*Command).Run(0xc0000bea20, 0xc0000a07c0)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/command.go:163 +0x5bb
github.com/urfave/cli/v2.(*App).RunAsSubcommand(0xc000087a00, 0xc0000a0700)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/app.go:434 +0xc8a
github.com/urfave/cli/v2.(*Command).startApp(0xc0000be900, 0xc0000a0700)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/command.go:278 +0x713
github.com/urfave/cli/v2.(*Command).Run(0xc0000a04c0?, 0x3?)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/command.go:94 +0xba
github.com/urfave/cli/v2.(*App).RunContext(0xc0000876c0, {0x6fdf40?, 0xc0000ae000}, {0xc0000a0000, 0x4, 0x4})
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/app.go:313 +0xb48
github.com/urfave/cli/v2.(*App).Run(...)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/app.go:224
main.main()
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/main.go:85 +0x445
root@nvidia-container-toolkit-1-12-0:~# nvidia-ctk --debug cdi generate --output=/etc/cdi/nvidia.yaml
...
INFO[0000] Selecting /dev/nvidiactl as /dev/nvidiactl   
DEBU[0000] Locating libnvidia-egl-gbm.so                
DEBU[0000] Looking up [libnvidia-egl-gbm.so] in cache   
DEBU[0000] checking /lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1 
DEBU[0000] Resolved link: '/lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1' => '/lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1.1.2' 
DEBU[0000] checking /lib/i386-linux-gnu/libnvidia-egl-gbm.so.1 
DEBU[0000] Resolved link: '/lib/i386-linux-gnu/libnvidia-egl-gbm.so.1' => '/lib/i386-linux-gnu/libnvidia-egl-gbm.so.1.1.2' 
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x2c pc=0x512482]

goroutine 1 [running]:
github.com/sirupsen/logrus.(*Logger).Logf(0xc0001d5920?, 0x1?, {0x6afab6?, 0x1?}, {0xc0000d4868?, 0x0?, 0x0?})
	/go/src/nvidia-container-toolkit/vendor/github.com/sirupsen/logrus/logger.go:152 +0x22
github.com/sirupsen/logrus.(*Logger).Warnf(...)
	/go/src/nvidia-container-toolkit/vendor/github.com/sirupsen/logrus/logger.go:178
github.com/NVIDIA/nvidia-container-toolkit/internal/lookup.library.Locate({0x0, {0x6fd1f8, 0xc000012910}, {0x6fd7a0, 0xc00009d540}}, {0x6a8592, 0x14})
	/go/src/nvidia-container-toolkit/internal/lookup/library.go:60 +0x1ab
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.(*mounts).Mounts(0xc000062a20)
	/go/src/nvidia-container-toolkit/internal/discover/mounts.go:71 +0x52b
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.list.Mounts({{0xc000056de0?, 0xc0001db200?, 0xc0000d4e78?}})
	/go/src/nvidia-container-toolkit/internal/discover/list.go:59 +0xa9
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.list.Mounts({{0xc0001e0960?, 0xc0001db240?, 0x2?}})
	/go/src/nvidia-container-toolkit/internal/discover/list.go:59 +0xa9
github.com/NVIDIA/nvidia-container-toolkit/internal/discover.list.Mounts({{0xc000056ea0?, 0xc000012b40?, 0x41b505300000100?}})
	/go/src/nvidia-container-toolkit/internal/discover/list.go:59 +0xa9
github.com/NVIDIA/nvidia-container-toolkit/internal/edits.FromDiscoverer({0x6fdc10, 0xc0001af9b0})
	/go/src/nvidia-container-toolkit/internal/edits/edits.go:57 +0xc2
github.com/NVIDIA/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate.command.generateSpec({0x69c8b6?}, {0x0, 0x0}, {0x6a781f, 0x13}, {0x6fda48, 0xc0000568a0})
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate/generate.go:263 +0xdaa
github.com/NVIDIA/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate.command.run({0x69bbb6?}, 0xc00009d4f0?, 0xc000012500)
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate/generate.go:134 +0x13f
github.com/NVIDIA/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate.command.build.func2(0xc00009d4a0?)
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/cdi/generate/generate.go:74 +0x27
github.com/urfave/cli/v2.(*Command).Run(0xc000094a20, 0xc0000607c0)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/command.go:163 +0x5bb
github.com/urfave/cli/v2.(*App).RunAsSubcommand(0xc0000851e0, 0xc000060700)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/app.go:434 +0xc8a
github.com/urfave/cli/v2.(*Command).startApp(0xc000094900, 0xc000060700)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/command.go:278 +0x713
github.com/urfave/cli/v2.(*Command).Run(0xc0000604c0?, 0x3?)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/command.go:94 +0xba
github.com/urfave/cli/v2.(*App).RunContext(0xc000084ea0, {0x6fdf40?, 0xc000016090}, {0xc0000120a0, 0x5, 0x5})
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/app.go:313 +0xb48
github.com/urfave/cli/v2.(*App).Run(...)
	/go/src/nvidia-container-toolkit/vendor/github.com/urfave/cli/v2/app.go:224
main.main()
	/go/src/nvidia-container-toolkit/cmd/nvidia-ctk/main.go:85 +0x445
```

The workaround is deleting `/lib/i386-linux-gnu/libnvidia-egl-gbm.so.1`.

```
root@nvidia-container-toolkit-1-12-0:~# rm /lib/i386-linux-gnu/libnvidia-egl-gbm.so.1
root@nvidia-container-toolkit-1-12-0:~# nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
WARN[0000] Failed to locate : pattern  not found        
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
WARN[0000] Could not locate /var/run/nvidia-persistenced/socket: pattern /var/run/nvidia-persistenced/socket not found 
WARN[0000] Could not locate /var/run/nvidia-fabricmanager/socket: pattern /var/run/nvidia-fabricmanager/socket not found 
WARN[0000] Could not locate /tmp/nvidia-mps: pattern /tmp/nvidia-mps not found 
INFO[0000] Using driver version 575.57.08               
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] found 64-bit driver lib: /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libcuda.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] found 64-bit driver lib: /lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libcuda.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] found 32-bit driver lib: /lib/i386-linux-gnu/libEGL_nvidia.so.575.57.08 
INFO[0000] Selecting /dev/nvidia-modeset as /dev/nvidia-modeset 
WARN[0000] Could not locate /dev/nvidia-uvm-tools: pattern /dev/nvidia-uvm-tools not found 
WARN[0000] Could not locate /dev/nvidia-uvm: pattern /dev/nvidia-uvm not found 
INFO[0000] Selecting /dev/nvidiactl as /dev/nvidiactl   
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1.1.2 as /lib/x86_64-linux-gnu/libnvidia-egl-gbm.so.1.1.2 
INFO[0000] Selecting /usr/share/glvnd/egl_vendor.d/10_nvidia.json as /usr/share/glvnd/egl_vendor.d/10_nvidia.json 
INFO[0000] Selecting /etc/vulkan/icd.d/nvidia_icd.json as /etc/vulkan/icd.d/nvidia_icd.json 
INFO[0000] Selecting /etc/vulkan/implicit_layer.d/nvidia_layers.json as /etc/vulkan/implicit_layer.d/nvidia_layers.json 
INFO[0000] Selecting /usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json as /usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json 
INFO[0000] Selecting /usr/share/egl/egl_external_platform.d/10_nvidia_wayland.json as /usr/share/egl/egl_external_platform.d/10_nvidia_wayland.json 
INFO[0000] Selecting /lib/x86_64-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 as /lib/x86_64-linux-gnu/libnvoptix.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-wayland-client.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-vksc-core.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-sandboxutils.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-rtcore.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-present.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-pkcs11.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-pkcs11-openssl3.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-ngx.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] Selecting /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 as /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-gtk3.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-gtk2.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-cfg.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 as /lib/x86_64-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 as /lib/x86_64-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 as /lib/x86_64-linux-gnu/libcudadebugger.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libcuda.so.575.57.08 as /lib/x86_64-linux-gnu/libcuda.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 as /lib/x86_64-linux-gnu/libEGL_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 as /lib/i386-linux-gnu/vdpau/libvdpau_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-tls.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-tls.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-ptxjitcompiler.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-opticalflow.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-opticalflow.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-opencl.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-opencl.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-nvvm.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-nvvm.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-ml.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-ml.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-gpucomp.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-gpucomp.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-glvkspirv.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-glvkspirv.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-glsi.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-glsi.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-glcore.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-glcore.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-fbc.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-fbc.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-encode.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-encode.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-eglcore.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-eglcore.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvidia-allocator.so.575.57.08 as /lib/i386-linux-gnu/libnvidia-allocator.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libnvcuvid.so.575.57.08 as /lib/i386-linux-gnu/libnvcuvid.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libcuda.so.575.57.08 as /lib/i386-linux-gnu/libcuda.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libGLX_nvidia.so.575.57.08 as /lib/i386-linux-gnu/libGLX_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libGLESv2_nvidia.so.575.57.08 as /lib/i386-linux-gnu/libGLESv2_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 as /lib/i386-linux-gnu/libGLESv1_CM_nvidia.so.575.57.08 
INFO[0000] Selecting /lib/i386-linux-gnu/libEGL_nvidia.so.575.57.08 as /lib/i386-linux-gnu/libEGL_nvidia.so.575.57.08 
WARN[0000] Could not locate /lib/firmware/nvidia/575.57.08/gsp.bin: pattern /lib/firmware/nvidia/575.57.08/gsp.bin not found 
INFO[0000] Selecting /usr/bin/nvidia-smi as /usr/bin/nvidia-smi 
INFO[0000] Selecting /usr/bin/nvidia-debugdump as /usr/bin/nvidia-debugdump 
INFO[0000] Selecting /usr/bin/nvidia-persistenced as /usr/bin/nvidia-persistenced 
INFO[0000] Selecting /usr/bin/nvidia-cuda-mps-control as /usr/bin/nvidia-cuda-mps-control 
INFO[0000] Selecting /usr/bin/nvidia-cuda-mps-server as /usr/bin/nvidia-cuda-mps-server 
INFO[0000] Using minimum required CDI spec version: 0.5.0
root@nvidia-container-toolkit-1-12-0:~# grep "  name:" /etc/cdi/nvidia.yaml
  name: "0"
  name: "1"
  name: "2"
  name: "3"
  name: all
root@nvidia-container-toolkit-1-12-0:~# sed -i s/auto/cdi/g /etc/nvidia-container-runtime/config.toml
root@nvidia-container-toolkit-1-12-0:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all busybox
8bf6cab1c0de8d63b48041d9c03de98d0ffa70c365a3695f33bf785fe415cd65
docker: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error running hook #0: error running hook: exit status 1, stdout: , stderr: time="2025-07-30T14:41:13Z" level=error msg="failed to update ld.so.conf: failed to create config file: open /var/lib/docker/overlay2/e77878052e00b8e4d8a17cfd86a72f819ab876ac595453ddc780fc420d3eb554/merged/etc/ld.so.conf.d/nvcr-1253295762.conf: no such file or directory": unknown.
root@nvidia-container-toolkit-1-12-0:~# docker run -tid --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all ubuntu
91102c2e46af7f6c1163b9c27da2e6366da708fac1beb463d7de4bb403a4e96c
root@nvidia-container-toolkit-1-12-0:~# cat /run/containerd/io.containerd.runtime.v2.task/moby/91102c2e46af7f6c1163b9c27da2e6366da708fac1beb463d7de4bb403a4e96c/config.json | jq .hooks
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
        "nvidia-ctk",
        "hook",
        "update-ldcache",
        "--folder",
        "/lib/x86_64-linux-gnu/vdpau",
        "--folder",
        "/lib/x86_64-linux-gnu",
        "--folder",
        "/lib/i386-linux-gnu",
        "--folder",
        "/lib/i386-linux-gnu/vdpau",
        "--folder",
        "/usr/lib/x86_64-linux-gnu"
      ]
    }
  ]
}
```

### fake-nvidia

```shell
root@nvidia-container-toolkit-1-12-0:~# nvidia-container-cli info
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
root@nvidia-container-toolkit-1-12-0:~# lsmod |grep fake
fake_nvidia_driver     16384  0
root@nvidia-container-toolkit-1-12-0:~# ls -lah /usr/lib/x86_64-linux-gnu/libnvidia-ml.so*
lrwxrwxrwx 1 root root  43 Jul 30 09:16 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
lrwxrwxrwx 1 root root  51 Jul 30 09:16 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 -> /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
-rwxr-xr-x 1 root root 22K Jul 30 09:16 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.575.57.08
root@nvidia-container-toolkit-1-12-0:~# systemctl status fake-nvidia-device
○ fake-nvidia-device.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-device.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Wed 2025-07-30 09:56:36 UTC; 4h 46min ago
    Process: 432 ExecStart=/usr/local/bin/fake-nvidia-device.sh (code=exited, status=0/SUCCESS)
   Main PID: 432 (code=exited, status=0/SUCCESS)
        CPU: 6ms

Jul 30 09:56:36 nvidia-container-toolkit-1-12-0 systemd[1]: Starting Create device nodes for fake nvidia driver...
Jul 30 09:56:36 nvidia-container-toolkit-1-12-0 systemd[1]: fake-nvidia-device.service: Deactivated successfully.
Jul 30 09:56:36 nvidia-container-toolkit-1-12-0 systemd[1]: Finished Create device nodes for fake nvidia driver.
```

### environment details

```shell
root@nvidia-container-toolkit-1-12-0:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.12.0
commit: 62bd015475656ef795cb0d59cc4030a6bd4a9526
root@nvidia-container-toolkit-1-12-0:~# docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.10.2
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.15.1
    Path:     /usr/libexec/docker/cli-plugins/docker-compose
  scan: Docker Scan (Docker Inc.)
    Version:  v0.23.0
    Path:     /usr/libexec/docker/cli-plugins/docker-scan

Server:
 Containers: 2
  Running: 1
  Paused: 0
  Stopped: 1
 Images: 2
 Server Version: 23.0.0
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
 containerd version: 31aa4358a36870b21a992d3ad2bef29e1d693bec
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
 Name: nvidia-container-toolkit-1-12-0
 ID: 2187a6d9-b763-4060-9e6f-1ea23c1a0851
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

root@nvidia-container-toolkit-1-12-0:~# containerd --version
containerd containerd.io 1.6.16 31aa4358a36870b21a992d3ad2bef29e1d693bec
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.12.0
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.12.0_v0.9.0
```
