# kubernetes v1.29.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.29.0 -> ssst0n3/docker_archive:kubernetes-v1.29.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.29.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.29.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.29.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.29.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.29.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS      AGE
kube-system   coredns-76f75df574-22bn7                    0/1     Pending   0             71m
kube-system   coredns-76f75df574-s77c7                    0/1     Pending   0             71m
kube-system   etcd-kubernetes-1-29-0                      1/1     Running   1 (12m ago)   71m
kube-system   kube-apiserver-kubernetes-1-29-0            1/1     Running   1 (12m ago)   71m
kube-system   kube-controller-manager-kubernetes-1-29-0   1/1     Running   1 (12m ago)   71m
kube-system   kube-proxy-4gqdv                            1/1     Running   1 (12m ago)   71m
kube-system   kube-scheduler-kubernetes-1-29-0            1/1     Running   1 (12m ago)   71m
```

```shell
$ ./ssh
root@kubernetes-1-29-0:~# helm version
version.BuildInfo{Version:"v3.14.0", GitCommit:"3fc9f4b2638e76f26739cd77c7017139be81d0ea", GitTreeState:"clean", GoVersion:"go1.21.5"}
root@kubernetes-1-29-0:~# kubectl version
Client Version: v1.29.0
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.29.0
root@kubernetes-1-29-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.1 1677a17964311325ed1c31e2c0a3589ce6d5c30d
root@kubernetes-1-29-0:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@kubernetes-1-29-0:~# uname -a
Linux kubernetes-1-29-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-29-0:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.29.0
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.29.0_v0.1.0
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
RUN --mount=type=cache,id=kubernetes-v1.29.0-snapshots,target=/trick \
    cp -r /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.29.0-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# copy snapshots from cache
# 1. copy owner attributions, fixed calico-kube-controllers crashloop issue
# 2. skip 'work' dir to avoid 'operation not permitted' error, caused by coping overlayfs whiteout files
RUN --mount=type=cache,id=kubernetes-v1.29.0-snapshots,target=/trick \
    tar -C /trick --exclude='work' -cf - . | tar -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

---
