# A CTF Challenge: your gpu my shell

* dqd:
    * ssst0n3/docker_archive:your-gpu-my-shell_ -> ssst0n3/docker_archive:your-gpu-my-shell_v0.1.0
    * ssst0n3/docker_archive:your-gpu-my-shell_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_your-gpu-my-shell -> ssst0n3/docker_archive:ctr_your-gpu-my-shell_v0.1.0
    * ssst0n3/docker_archive:ctr_your-gpu-my-shell_v0.1.0

## usage

### Recommend

```shell
$ cd ctf/your-gpu-my-shell
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### Without kvm

KVM can speed up the environment, but it can also be started without KVM.

```shell
$ cd ctf/your-gpu-my-shell
$ docker compose -f docker-compose.yml up -d
```

### Docker Image Mirror

```shell
$ cd ctf/your-gpu-my-shell
$ docker compose -f docker-compose.yml -f docker-compose.mirror.yml up -d
```

## writeup

// TODO: You could upload your writeup here.

## challenge description

Welcome to our state-of-the-art GPU-accelerated computing service! We provide a secure, containerized environment for you to run any Docker image of your choice.

Your task is simple:
1. Connect to the service.
2. Solve the initial Proof-of-Work challenge.
3. Specify a Docker image to run.
4. Escape from the container and capture the flag.

You will be granted shell access inside a container with direct access to the host's NVIDIA GPU devices. We are confident that our sandbox is inescapable.

The flag is located on the host system at `/flag`. Can you break out and capture it?

```shell
$ nc 127.0.0.1 25878
Welcome! The connection will be terminated after 5m0s.
sha256(xxxx+PWc9p0CTnY5tnets) == a83a2d10a0467c13b2ce68ac18587a81a7340ce60fcd2d55dc42756810e00c82
Give me xxxx:
ZMDM
Proof of Work successful!
Please enter the Docker image to run (e.g., busybox:latest): busybox:latest
Pulling image busybox:latest... This may take a moment.
{"status":"Pulling from library/busybox","id":"latest"}
{"status":"Digest: sha256:f9a104fddb33220ec80fc45a4e606c74aadf1ef7a3832eb0b05be9e90cd61f5f"}
{"status":"Status: Image is up to date for busybox:latest"}
Image pull complete.
Creating container with GPU support...
--- Connected to container terminal (with GPU support) ---
You can now type commands. The session will end after 5 minutes or when you exit the shell.
Try running 'ls -lah /dev/nvidia*' to verify GPU access.
/ # ls -lah /dev/nvidia*
ls -lah /dev/nvidia*
crw-rw-rw-    1 root     root      195,   0 Aug  8 02:49 /dev/nvidia0
crw-rw-rw-    1 root     root      195,   1 Aug  8 02:49 /dev/nvidia1
crw-rw-rw-    1 root     root      195,   2 Aug  8 02:49 /dev/nvidia2
crw-rw-rw-    1 root     root      195,   3 Aug  8 02:49 /dev/nvidia3
crw-rw-rw-    1 root     root      195, 255 Aug  8 02:49 /dev/nvidiactl
/ # 
```

## env details

```shell
$ ./ssh
root@your-gpu-my-shell:~# cat /etc/nvidia-container-runtime/config.toml 
#accept-nvidia-visible-devices-as-volume-mounts = false
#accept-nvidia-visible-devices-envvar-when-unprivileged = true
disable-require = false
supported-driver-capabilities = "compat32,compute,display,graphics,ngx,utility,video"
#swarm-resource = "DOCKER_RESOURCE_GPU"

[nvidia-container-cli]
#debug = "/var/log/nvidia-container-toolkit.log"
environment = []
#ldcache = "/etc/ld.so.cache"
ldconfig = "@/sbin/ldconfig.real"
load-kmods = true
#no-cgroups = false
#path = "/usr/bin/nvidia-container-cli"
#root = "/run/nvidia/driver"
#user = "root:video"

[nvidia-container-runtime]
#debug = "/var/log/nvidia-container-runtime.log"
log-level = "info"
mode = "legacy"
runtimes = ["docker-runc", "runc", "crun"]

[nvidia-container-runtime.modes]

[nvidia-container-runtime.modes.cdi]
annotation-prefixes = ["cdi.k8s.io/"]
default-kind = "nvidia.com/gpu"
spec-dirs = ["/etc/cdi", "/var/run/cdi"]

[nvidia-container-runtime.modes.csv]
mount-spec-path = "/etc/nvidia-container-runtime/host-files-for-container.d"

[nvidia-container-runtime-hook]
path = "nvidia-container-runtime-hook"
skip-mode-detection = false

[nvidia-ctk]
path = "nvidia-ctk"

[features]
disable-cuda-compat-lib-hook = true
root@your-gpu-my-shell:~# cat /etc/nvidia-container-runtime/config.toml 
#accept-nvidia-visible-devices-as-volume-mounts = false
#accept-nvidia-visible-devices-envvar-when-unprivileged = true
disable-require = false
supported-driver-capabilities = "compat32,compute,display,graphics,ngx,utility,video"
#swarm-resource = "DOCKER_RESOURCE_GPU"

[nvidia-container-cli]
#debug = "/var/log/nvidia-container-toolkit.log"
environment = []
#ldcache = "/etc/ld.so.cache"
ldconfig = "@/sbin/ldconfig.real"
load-kmods = true
#no-cgroups = false
#path = "/usr/bin/nvidia-container-cli"
#root = "/run/nvidia/driver"
#user = "root:video"

[nvidia-container-runtime]
#debug = "/var/log/nvidia-container-runtime.log"
log-level = "info"
mode = "legacy"
runtimes = ["docker-runc", "runc", "crun"]

[nvidia-container-runtime.modes]

[nvidia-container-runtime.modes.cdi]
annotation-prefixes = ["cdi.k8s.io/"]
default-kind = "nvidia.com/gpu"
spec-dirs = ["/etc/cdi", "/var/run/cdi"]

[nvidia-container-runtime.modes.csv]
mount-spec-path = "/etc/nvidia-container-runtime/host-files-for-container.d"

[nvidia-container-runtime-hook]
path = "nvidia-container-runtime-hook"
skip-mode-detection = false

[nvidia-ctk]
path = "nvidia-ctk"

[features]
disable-cuda-compat-lib-hook = true
root@your-gpu-my-shell:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.6
commit: e627eb2e21e167988e04c0579a1c941c1e263ff6
root@your-gpu-my-shell:~# docker info
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
 Containers: 4
  Running: 0
  Paused: 0
  Stopped: 4
 Images: 3
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
 Runtimes: runc io.containerd.runc.v2 nvidia
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
 Kernel Version: 6.8.0-71-generic
 Operating System: Ubuntu 24.04.2 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.922GiB
 Name: your-gpu-my-shell
 ID: c7999750-1d8d-4f68-9dd6-e90df1d4f235
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false

root@your-gpu-my-shell:~# containerd --version
containerd containerd.io 1.7.27 05044ec0a9a75232cad458027ca83437aae3f4da
```

## build

```shell
make all DIR=ctf/your-gpu-my-shell
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_your-gpu-my-shell_v0.1.0
```
