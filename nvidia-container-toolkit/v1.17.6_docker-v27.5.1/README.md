# nvidia-container-toolkit v1.17.6 with docker v27.5.1

* dqd:
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6_docker-v27.5.1 -> ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6_docker-v27.5.1_v0.1.0
  * ssst0n3/docker_archive:nvidia-container-toolkit-v1.17.6_docker-v27.5.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6_docker-v27.5.1 -> ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6_docker-v27.5.1_v0.1.0
  * ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6_docker-v27.5.1_v0.1.0

## usage

```shell
$ cd nvidia-container-toolkit/v1.17.6_docker-v27.5.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ ./ssh
root@localhost:~# docker run -ti --runtime=nvidia --gpus=all busybox
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
90b9666d4aed: Pull complete 
Digest: sha256:f85340bf132ae937d2c2a763b8335c9bab35d6e8293f70f606b9c6178d84f42b
Status: Downloaded newer image for busybox:latest
/ # 
```

```shell
$ ./ssh
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.6
commit: e627eb2e21e167988e04c0579a1c941c1e263ff6
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# lsmod |grep fake
fake_nvidia_driver     12288  0
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# ls -lah /usr/local/lib/libnvidia-ml.so.1
-rwxr-xr-x 1 root root 22K Jul 23 07:13 /usr/local/lib/libnvidia-ml.so.1
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# systemctl status fake-nvidia-mknod
○ fake-nvidia-mknod.service - Create device nodes for fake nvidia driver
     Loaded: loaded (/etc/systemd/system/fake-nvidia-mknod.service; enabled; preset: enabled)
     Active: inactive (dead) since Wed 2025-07-23 07:38:29 UTC; 1min 53s ago
    Process: 650 ExecStart=/usr/local/bin/fake-nvidia-mknod.sh (code=exited, status=0/SUCCESS)
   Main PID: 650 (code=exited, status=0/SUCCESS)
        CPU: 7ms

Jul 23 07:38:29 nvidia-container-toolkit-1-17-6-docker-27-5-1 systemd[1]: Starting fake-nvidia-mknod.service - Create device nodes for fake nvidia driver...
Jul 23 07:38:29 nvidia-container-toolkit-1-17-6-docker-27-5-1 systemd[1]: fake-nvidia-mknod.service: Deactivated successfully.
Jul 23 07:38:29 nvidia-container-toolkit-1-17-6-docker-27-5-1 systemd[1]: Finished fake-nvidia-mknod.service - Create device nodes for fake nvidia driver.
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# nvidia-container-cli info
NVRM version:   535.104.05
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
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# docker version
Client: Docker Engine - Community
 Version:           27.5.1
 API version:       1.47
 Go version:        go1.22.11
 Git commit:        9f9e405
 Built:             Wed Jan 22 13:41:48 2025
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          27.5.1
  API version:      1.47 (minimum version 1.24)
  Go version:       go1.22.11
  Git commit:       4c9b3b0
  Built:            Wed Jan 22 13:41:48 2025
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.25
  GitCommit:        bcc810d6b9066471b0b6fa75f557a15a1cbf31bb
 runc:
  Version:          1.2.4
  GitCommit:        v1.2.4-0-g6c52b3f
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# cat /etc/os-release
PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
root@nvidia-container-toolkit-1-17-6-docker-27-5-1:~# uname -a
Linux nvidia-container-toolkit-1-17-6-docker-27-5-1 6.8.0-64-generic #67-Ubuntu SMP PREEMPT_DYNAMIC Sun Jun 15 20:23:31 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=nvidia-container-toolkit/v1.17.6_docker-v27.5.1
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nvidia-container-toolkit-v1.17.6_docker-v27.5.1_v0.1.0
```
