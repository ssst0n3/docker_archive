# kubernetes v1.26.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.26.0 -> ssst0n3/docker_archive:kubernetes-v1.26.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.26.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.26.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.26.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.26.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.26.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A             
NAMESPACE     NAME                                        READY   STATUS    RESTARTS        AGE
kube-system   coredns-787d4945fb-bk2dm                    0/1     Pending   0               10m
kube-system   coredns-787d4945fb-wh7fs                    0/1     Pending   0               10m
kube-system   etcd-kubernetes-1-26-0                      1/1     Running   1 (2m10s ago)   10m
kube-system   kube-apiserver-kubernetes-1-26-0            1/1     Running   1 (2m10s ago)   10m
kube-system   kube-controller-manager-kubernetes-1-26-0   1/1     Running   1 (2m10s ago)   10m
kube-system   kube-proxy-hcs5q                            1/1     Running   1 (2m10s ago)   10m
kube-system   kube-scheduler-kubernetes-1-26-0            1/1     Running   1 (2m10s ago)   10m
```

```shell
$ ./ssh
root@kubernetes-1-26-0:~# helm version
version.BuildInfo{Version:"v3.11.0", GitCommit:"472c5736ab01133de504a826bd9ee12cbe4e7904", GitTreeState:"clean", GoVersion:"go1.18.10"}
root@kubernetes-1-26-0:~# kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.0", GitCommit:"b46a3f887ca979b1a5d14fd39cb1af43e7e5d12d", GitTreeState:"clean", BuildDate:"2022-12-08T19:58:30Z", GoVersion:"go1.19.4", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.0", GitCommit:"b46a3f887ca979b1a5d14fd39cb1af43e7e5d12d", GitTreeState:"clean", BuildDate:"2022-12-08T19:51:45Z", GoVersion:"go1.19.4", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-26-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.9 1c90a442489720eec95342e1789ee8a5e1b9536f
root@kubernetes-1-26-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@kubernetes-1-26-0:~# uname -a
Linux kubernetes-1-26-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-26-0:~# cat /etc/os-release 
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
make all DIR=kubernetes/v1.26.0
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.26.0_v0.1.0
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
# use cp -a instead of cp -r to preserve attributions, avoid coredns cap_net_bind_service loss
RUN --mount=type=cache,id=kubernetes-v1.26.0-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# install calico
RUN --mount=type=cache,id=kubernetes-v1.26.0-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# copy snapshots from cache
# 1. copy owner attributions, fixed calico-kube-controllers crashloop issue
# 2. skip 'work' dir to avoid 'operation not permitted' error, caused by coping overlayfs whiteout files
# 3. use --xattrs, --xattrs-include to preserve file capabilities
RUN --mount=type=cache,id=kubernetes-v1.26.0-snapshots,target=/trick \
    tar --xattrs --xattrs-include='*' -C /trick --exclude='work' -cf - . | \
    tar --xattrs --xattrs-include='*' -C /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/ -xf -
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

---
