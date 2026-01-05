# kubernetes v1.32.2 with containerd v2.0.3

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3 -> ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3 -> ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3_v0.1.0

## usage

```shell
$ cd kubernetes/v1.32.2_containerd-v2.0.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                                         READY   STATUS    RESTARTS        AGE
kube-system   coredns-668d6bf9bc-9shxm                                     0/1     Pending   0               12m
kube-system   coredns-668d6bf9bc-bjng9                                     0/1     Pending   0               12m
kube-system   etcd-kubernetes-1-32-2-containerd-2-0-3                      1/1     Running   1 (5m55s ago)   12m
kube-system   kube-apiserver-kubernetes-1-32-2-containerd-2-0-3            1/1     Running   1 (5m55s ago)   12m
kube-system   kube-controller-manager-kubernetes-1-32-2-containerd-2-0-3   1/1     Running   1 (5m55s ago)   12m
kube-system   kube-proxy-pwv8p                                             1/1     Running   1 (5m55s ago)   12m
kube-system   kube-scheduler-kubernetes-1-32-2-containerd-2-0-3            1/1     Running   1 (5m55s ago)   12m
```

```shell
$ ./ssh
root@kubernetes-1-32-2-containerd-2-0-3:~# helm version
version.BuildInfo{Version:"v3.16.4", GitCommit:"7877b45b63f95635153b29a42c0c2f4273ec45ca", GitTreeState:"clean", GoVersion:"go1.22.7"}
root@kubernetes-1-32-2-containerd-2-0-3:~# kubectl version
Client Version: v1.32.2
Kustomize Version: v5.5.0
Server Version: v1.32.2
root@kubernetes-1-32-2-containerd-2-0-3:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.3 06b99ca80cdbfbc6cc8bd567021738c9af2b36ce
root@kubernetes-1-32-2-containerd-2-0-3:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@kubernetes-1-32-2-containerd-2-0-3:~# cat /etc/os-release 
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
root@kubernetes-1-32-2-containerd-2-0-3:~# uname -a
Linux kubernetes-1-32-2-containerd-2-0-3 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.32.2_containerd-v2.0.3
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3_v0.1.0
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
RUN --mount=type=cache,id=kubernetes-v1.32.2_containerd-v2.0.3-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.32.2_containerd-v2.0.3-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0)
RUN --mount=type=cache,id=kubernetes-v1.32.2_containerd-v2.0.3-snapshots,target=/trick \
    # all these files are safe to delete, list each file path here for more clear
    rm /trick/snapshots/55/work/work/#* && \
    # use tar to preserve file capabilities
    tar -C /trick -cf - . | tar -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

> NOTE: mknod is not allowed on overlayfs, even when running as a privileged container.
