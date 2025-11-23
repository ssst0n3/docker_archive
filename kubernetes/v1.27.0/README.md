# kubernetes v1.27.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.27.0 -> ssst0n3/docker_archive:kubernetes-v1.27.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.27.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.27.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.27.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.27.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.27.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS      AGE
kube-system   coredns-5d78c9869d-b4pv8                    0/1     Pending   0             10m
kube-system   coredns-5d78c9869d-zb7mz                    0/1     Pending   0             10m
kube-system   etcd-kubernetes-1-27-0                      1/1     Running   1 (82s ago)   10m
kube-system   kube-apiserver-kubernetes-1-27-0            1/1     Running   1 (82s ago)   10m
kube-system   kube-controller-manager-kubernetes-1-27-0   1/1     Running   1 (82s ago)   10m
kube-system   kube-proxy-r9bt7                            1/1     Running   1 (82s ago)   10m
kube-system   kube-scheduler-kubernetes-1-27-0            1/1     Running   1 (82s ago)   10m
```

```shell
$ ./ssh
root@kubernetes-1-27-0:~# helm version
version.BuildInfo{Version:"v3.12.0", GitCommit:"c9f554d75773799f72ceef38c51210f1842a1dea", GitTreeState:"clean", GoVersion:"go1.20.3"}
root@kubernetes-1-27-0:~# kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.0", GitCommit:"1b4df30b3cdfeaba6024e81e559a6cd09a089d65", GitTreeState:"clean", BuildDate:"2023-04-11T17:10:18Z", GoVersion:"go1.20.3", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v5.0.1
Server Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.0", GitCommit:"1b4df30b3cdfeaba6024e81e559a6cd09a089d65", GitTreeState:"clean", BuildDate:"2023-04-11T17:04:24Z", GoVersion:"go1.20.3", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-27-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.19 1e1ea6e986c6c86565bc33d52e34b81b3e2bc71f
root@kubernetes-1-27-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@kubernetes-1-27-0:~# uname -a
Linux kubernetes-1-27-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-27-0:~# cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

## build

```shell
make all DIR=kubernetes/v1.27.0
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.27.0_v0.1.0
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
# Run kubeadm within an ext4 filesystem using a cached mount
RUN --mount=type=cache,id=kubernetes-v1.27.0-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]

# Restore cached containerd snapshots
RUN --mount=type=cache,id=kubernetes-v1.27.0-snapshots,target=/trick \
    cp -r /trick /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

---
