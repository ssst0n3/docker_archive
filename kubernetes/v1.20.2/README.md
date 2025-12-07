# kubernetes v1.20.2

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.20.2 -> ssst0n3/docker_archive:kubernetes-v1.20.2_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.20.2_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.20.2 -> ssst0n3/docker_archive:ctr_kubernetes-v1.20.2_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.20.2_v0.1.0

## usage

```shell
$ cd kubernetes/v1.20.2
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS   AGE
kube-system   coredns-74ff55c5b-2c2xh                     0/1     Pending   0          13m
kube-system   coredns-74ff55c5b-p2mp2                     0/1     Pending   0          13m
kube-system   etcd-kubernetes-1-20-2                      1/1     Running   1          13m
kube-system   kube-apiserver-kubernetes-1-20-2            1/1     Running   1          13m
kube-system   kube-controller-manager-kubernetes-1-20-2   1/1     Running   1          13m
kube-system   kube-proxy-2rpbw                            1/1     Running   1          13m
kube-system   kube-scheduler-kubernetes-1-20-2            1/1     Running   1          13m
```

```shell
$ ./ssh
root@kubernetes-1-20-2:~# helm version
version.BuildInfo{Version:"v3.5.0", GitCommit:"32c22239423b3b4ba6706d450bd044baffdcf9e6", GitTreeState:"clean", GoVersion:"go1.15.6"}
root@kubernetes-1-20-2:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.2", GitCommit:"faecb196815e248d3ecfb03c680a4507229c2a56", GitTreeState:"clean", BuildDate:"2021-01-13T13:28:09Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.2", GitCommit:"faecb196815e248d3ecfb03c680a4507229c2a56", GitTreeState:"clean", BuildDate:"2021-01-13T13:20:00Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-20-2:~# containerd --version
containerd github.com/containerd/containerd v1.4.0 09814d48d50816305a8e6c1a4ae3e2bcc4ba725a
root@kubernetes-1-20-2:~# runc --version
runc version 1.0.0-rc92
spec: 1.0.2-dev
root@kubernetes-1-20-2:~# uname -a
Linux kubernetes-1-20-2 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-20-2:~# cat /etc/os-release
NAME="Ubuntu"
VERSION="20.04.6 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.6 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

## build

```shell
make all DIR=kubernetes/v1.20.2
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.20.2_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug

## Tricks

### 1. Use a cache mount to avoid overlayfs-on-overlayfs errors

If you encounter the following error:

```
[ 2237.540485] overlayfs: filesystem on '/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/72/fs' not supported as upperdir
```

it typically means an **overlayfs** is being mounted over another **overlayfs**.  
You can solve this issue by using a **cache mount** within your build process.

**Example:**

```Dockerfile
# copy image snapshots
RUN --mount=type=cache,id=kubernetes-v1.20.2-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.20.2-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0)
RUN --mount=type=cache,id=kubernetes-v1.20.2-snapshots,target=/trick \
    # all these files are safe to delete, list each file path here for more clear
    cd /trick/snapshots/28/fs && rm \
        var/lib/apt/lists/security.debian.org_debian-security_dists_buster_updates_main_binary-amd64_Packages.lz4 \
        var/lib/apt/lists/deb.debian.org_debian_dists_buster-updates_main_binary-amd64_Packages.lz4 \
        var/lib/apt/lists/deb.debian.org_debian_dists_buster-backports_InRelease \
        var/lib/apt/lists/lock \
        var/lib/apt/lists/deb.debian.org_debian_dists_buster_main_binary-amd64_Packages.lz4 \
        var/lib/apt/lists/partial \
        var/lib/apt/lists/deb.debian.org_debian_dists_buster-updates_InRelease \
        var/lib/apt/lists/deb.debian.org_debian_dists_buster_InRelease \
        var/lib/apt/lists/deb.debian.org_debian_dists_buster-backports_main_binary-amd64_Packages.lz4 \
        var/lib/apt/lists/auxfiles \
        var/lib/apt/lists/security.debian.org_debian-security_dists_buster_updates_InRelease \
        var/log/alternatives.log \
        var/log/dpkg.log \
        var/log/apt \
        var/cache/debconf/templates.dat \
        var/cache/debconf/passwords.dat \
        var/cache/debconf/config.dat && \
    # use tar to preserve file capabilities
    tar -C /trick -cf - . | tar -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

> NOTE: mknod is not allowed on overlayfs, even when running as a privileged container.

---

### 2. Fix `systemctl exit 0` inside containers

When running `systemctl exit 0`, you might see this warning:

```
ExitCode can only be set for user service managers or in containers.
```

This happens because `systemd` only allows this command in a detected "container environment".  
To fix this, define the container environment variable before running systemd:

```Dockerfile
# Workaround for systemd bug affecting `systemctl exit 0`
ENV container=docker
```

Setting `ENV container=docker` ensures that systemd recognizes the environment as a container, allowing graceful exits via `systemctl exit 0`.
