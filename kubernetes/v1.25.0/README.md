# kubernetes v1.25.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.25.0 -> ssst0n3/docker_archive:kubernetes-v1.25.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.25.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.25.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.25.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.25.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.25.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS        AGE
kube-system   coredns-565d847f94-nrdw4                    0/1     Pending   0               3h15m
kube-system   coredns-565d847f94-qh9sd                    0/1     Pending   0               3h15m
kube-system   etcd-kubernetes-1-25-0                      1/1     Running   1 (2m49s ago)   3h15m
kube-system   kube-apiserver-kubernetes-1-25-0            1/1     Running   1 (2m49s ago)   3h15m
kube-system   kube-controller-manager-kubernetes-1-25-0   1/1     Running   1 (2m49s ago)   3h15m
kube-system   kube-proxy-hnwnb                            1/1     Running   1 (2m49s ago)   3h15m
kube-system   kube-scheduler-kubernetes-1-25-0            1/1     Running   1 (2m49s ago)   3h15m
```

```shell
$ ./ssh
root@kubernetes-1-25-0:~# helm version
version.BuildInfo{Version:"v3.10.0", GitCommit:"ce66412a723e4d89555dc67217607c6579ffcb21", GitTreeState:"clean", GoVersion:"go1.18.6"}
root@kubernetes-1-25-0:~# kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.0", GitCommit:"a866cbe2e5bbaa01cfd5e969aa3e033f3282a8a2", GitTreeState:"clean", BuildDate:"2022-08-23T17:44:59Z", GoVersion:"go1.19", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.0", GitCommit:"a866cbe2e5bbaa01cfd5e969aa3e033f3282a8a2", GitTreeState:"clean", BuildDate:"2022-08-23T17:38:15Z", GoVersion:"go1.19", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-25-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.7 0197261a30bf81f1ee8e6a4dd2dea0ef95d67ccb
root@kubernetes-1-25-0:~# runc --version
runc version 1.1.3
commit: v1.1.3-0-g6724737f
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@kubernetes-1-25-0:~# uname -a
Linux kubernetes-1-25-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-25-0:~# cat /etc/os-release 
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
make all DIR=kubernetes/v1.25.0
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.25.0_v0.1.0
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
RUN --mount=type=cache,id=kubernetes-v1.25.0-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]

# Restore cached containerd snapshots
RUN --mount=type=cache,id=kubernetes-v1.25.0-snapshots,target=/trick \
    cp -r /trick /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

---
