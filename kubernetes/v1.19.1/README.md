# kubernetes v1.19.1

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.19.1 -> ssst0n3/docker_archive:kubernetes-v1.19.1_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.19.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.19.1 -> ssst0n3/docker_archive:ctr_kubernetes-v1.19.1_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.19.1_v0.1.0

## usage

```shell
$ cd kubernetes/v1.19.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS   AGE
kube-system   coredns-f9fd979d6-gmgbp                     0/1     Pending   0          13m
kube-system   coredns-f9fd979d6-zb8c4                     0/1     Pending   0          13m
kube-system   etcd-kubernetes-1-19-1                      1/1     Running   1          14m
kube-system   kube-apiserver-kubernetes-1-19-1            1/1     Running   1          14m
kube-system   kube-controller-manager-kubernetes-1-19-1   1/1     Running   1          14m
kube-system   kube-proxy-8gg8l                            1/1     Running   1          13m
kube-system   kube-scheduler-kubernetes-1-19-1            1/1     Running   1          14m
```

```shell
$ ./ssh
root@kubernetes-1-19-1:~# helm version
version.BuildInfo{Version:"v3.4.0", GitCommit:"7090a89efc8a18f3d8178bf47d2462450349a004", GitTreeState:"clean", GoVersion:"go1.14.10"}
root@kubernetes-1-19-1:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.1", GitCommit:"206bcadf021e76c27513500ca24182692aabd17e", GitTreeState:"clean", BuildDate:"2020-09-09T11:26:42Z", GoVersion:"go1.15", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.1", GitCommit:"206bcadf021e76c27513500ca24182692aabd17e", GitTreeState:"clean", BuildDate:"2020-09-09T11:18:22Z", GoVersion:"go1.15", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-19-1:~# containerd --version
containerd github.com/containerd/containerd v1.4.0 09814d48d50816305a8e6c1a4ae3e2bcc4ba725a
root@kubernetes-1-19-1:~# runc --version
runc version 1.0.0-rc92
spec: 1.0.2-dev
root@kubernetes-1-19-1:~# uname -a
Linux kubernetes-1-19-1 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-19-1:~# cat /etc/os-release 
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
make all DIR=kubernetes/v1.19.1
```


## for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.19.1_v0.1.0
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
RUN --mount=type=cache,id=kubernetes-v1.19.1-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]

# Restore cached containerd snapshots
RUN --mount=type=cache,id=kubernetes-v1.19.1-snapshots,target=/trick \
    cp -r /trick /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots
```

This approach stores containerd snapshots in a temp cache directory, avoiding nested overlayfs layers and improving build consistency.

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
