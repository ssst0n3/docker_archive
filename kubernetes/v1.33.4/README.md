# kubernetes v1.33.4

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.4 -> ssst0n3/docker_archive:kubernetes-v1.33.4_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.4_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.4 -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.4_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.4_v0.1.0

## usage

### startup

```shell
$ cd kubernetes/v1.33.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### built-in pods

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS      AGE
kube-system   coredns-674b8bbfcf-8skvj                    0/1     Pending   0             6m24s
kube-system   coredns-674b8bbfcf-gmz7l                    0/1     Pending   0             6m24s
kube-system   etcd-kubernetes-1-33-4                      1/1     Running   1 (51s ago)   6m32s
kube-system   kube-apiserver-kubernetes-1-33-4            1/1     Running   1 (51s ago)   6m32s
kube-system   kube-controller-manager-kubernetes-1-33-4   1/1     Running   1 (51s ago)   6m32s
kube-system   kube-proxy-9p5bw                            1/1     Running   1 (51s ago)   6m24s
kube-system   kube-scheduler-kubernetes-1-33-4            1/1     Running   1 (51s ago)   6m32s
```

### versions

```shell
$ ./ssh
root@kubernetes-1-33-4:~# kubectl version
Client Version: v1.33.4
Kustomize Version: v5.6.0
Server Version: v1.33.4
root@kubernetes-1-33-4:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.4 75cb2b7193e4e490e9fbdc236c0e811ccaba3376
root@kubernetes-1-33-4:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
```

```shell
root@kubernetes-1-33-4:~# nerdctl version
Client:
 Version:	v2.1.4
 OS/Arch:	linux/amd64
 Git commit:	d216470b48cdb8d4c35688ad62fde299d0353e72
 buildctl:
  Version:	v0.24.0
  GitCommit:	b772c318368090fb2ffc9c0fed92e0a35bf82389

Server:
 containerd:
  Version:	v2.1.4
  GitCommit:	75cb2b7193e4e490e9fbdc236c0e811ccaba3376
 runc:
  Version:	1.3.0
  GitCommit:	v1.3.0-0-g4ca628d1
root@kubernetes-1-33-4:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.24.0 b772c318368090fb2ffc9c0fed92e0a35bf82389
root@kubernetes-1-33-4:~# helm version
version.BuildInfo{Version:"v3.18.4", GitCommit:"d80839cf37d860c8aa9a0503fe463278f26cd5e2", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-4:~# cat /etc/os-release
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
root@kubernetes-1-33-4:~# uname -a
Linux kubernetes-1-33-4 6.8.0-94-generic #96-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan  9 20:36:55 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.33.4
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.4_v0.1.0
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
RUN --mount=type=cache,id=kubernetes-v1.33.4-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.33.4-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0)
RUN --mount=type=cache,id=kubernetes-v1.33.4-snapshots,target=/trick \
    # all these files are safe to delete, list each file path here for more clear
    rm /trick/snapshots/55/work/work/#* && \
    # use tar to preserve file capabilities
    tar -C /trick -cf - . | tar -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

> NOTE: mknod is not allowed on overlayfs, even when running as a privileged container.
