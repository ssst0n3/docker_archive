# kubernetes v1.33.3 with containerd v2.1.1

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.3_containerd-v2.1.1 -> ssst0n3/docker_archive:kubernetes-v1.33.3_containerd-v2.1.1_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.3_containerd-v2.1.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.1 -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.1_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.1_v0.1.0

## usage

### startup

```shell
$ cd kubernetes/v1.33.3_containerd-v2.1.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### kubectl

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                                         READY   STATUS    RESTARTS      AGE
kube-system   coredns-674b8bbfcf-6pprd                                     0/1     Pending   0             13m
kube-system   coredns-674b8bbfcf-z9dm4                                     0/1     Pending   0             13m
kube-system   etcd-kubernetes-1-33-3-containerd-2-1-1                      1/1     Running   1 (45s ago)   13m
kube-system   kube-apiserver-kubernetes-1-33-3-containerd-2-1-1            1/1     Running   1 (45s ago)   13m
kube-system   kube-controller-manager-kubernetes-1-33-3-containerd-2-1-1   1/1     Running   1 (45s ago)   13m
kube-system   kube-proxy-8jrzj                                             1/1     Running   1 (45s ago)   13m
kube-system   kube-scheduler-kubernetes-1-33-3-containerd-2-1-1            1/1     Running   1 (45s ago)   13m
```

### container core components

```shell
$ ./ssh
root@kubernetes-1-33-3-containerd-2-1-1:~# kubectl version
Client Version: v1.33.3
Kustomize Version: v5.6.0
Server Version: v1.33.3
root@kubernetes-1-33-3-containerd-2-1-1:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.1 cb1076646aa3740577fafbf3d914198b7fe8e3f7
root@kubernetes-1-33-3-containerd-2-1-1:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
```

### related components

```shell
root@kubernetes-1-33-3-containerd-2-1-1:~# nerdctl version
Client:
 Version:	v2.1.2
 OS/Arch:	linux/amd64
 Git commit:	2a2834dd1c926528aa141726a9a9132eb1665568
 buildctl:
  Version:	v0.21.1
  GitCommit:	66735c67040bc80e6ed104f451683e094030a4e1

Server:
 containerd:
  Version:	v2.1.1
  GitCommit:	cb1076646aa3740577fafbf3d914198b7fe8e3f7
 runc:
  Version:	1.3.0
  GitCommit:	v1.3.0-0-g4ca628d1
root@kubernetes-1-33-3-containerd-2-1-1:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.21.1 66735c67040bc80e6ed104f451683e094030a4e1
root@kubernetes-1-33-3-containerd-2-1-1:~# helm version
version.BuildInfo{Version:"v3.18.4", GitCommit:"d80839cf37d860c8aa9a0503fe463278f26cd5e2", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-3-containerd-2-1-1:~# cat /etc/os-release
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
root@kubernetes-1-33-3-containerd-2-1-1:~# uname -a
Linux kubernetes-1-33-3-containerd-2-1-1 6.8.0-94-generic #96-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan  9 20:36:55 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.33.3_containerd-v2.1.1
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.1_v0.1.0
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
RUN --mount=type=cache,id=kubernetes-v1.33.3_containerd-v2.1.1-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.33.3_containerd-v2.1.1-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0)
RUN --mount=type=cache,id=kubernetes-v1.33.3_containerd-v2.1.1-snapshots,target=/trick \
    # all these files are safe to delete, list each file path here for more clear
    rm /trick/snapshots/55/work/work/#* && \
    # use tar to preserve file capabilities
    tar -C /trick -cf - . | tar -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

> NOTE: mknod is not allowed on overlayfs, even when running as a privileged container.
