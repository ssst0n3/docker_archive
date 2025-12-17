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
kube-system   coredns-f9fd979d6-52nmf                     0/1     Pending   0          36m
kube-system   coredns-f9fd979d6-6zd7n                     0/1     Pending   0          36m
kube-system   etcd-kubernetes-1-19-1                      1/1     Running   1          36m
kube-system   kube-apiserver-kubernetes-1-19-1            1/1     Running   1          36m
kube-system   kube-controller-manager-kubernetes-1-19-1   1/1     Running   1          36m
kube-system   kube-proxy-5n5jm                            1/1     Running   1          36m
kube-system   kube-scheduler-kubernetes-1-19-1            1/1     Running   1          36m
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
# copy image snapshots
RUN --mount=type=cache,id=kubernetes-v1.19.1-snapshots,target=/trick \
    cp -a /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/* /trick/
# kubeadm init under ext4 fs
RUN --mount=type=cache,id=kubernetes-v1.19.1-snapshots,target=/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs \
    # fix kube-proxy `Failed to load kernel module`
    --mount=type=bind,src=/modules,target=/lib/modules \
    --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
# skip overlayfs whiteout files (c 0,0) , overlayfs does not allow mknod even privileged container
# fix: `#20 5.255 cp: cannot create special file '/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/27/fs/var/cache/debconf/config.dat': Operation not permitted`
RUN --mount=type=cache,id=kubernetes-v1.19.1-snapshots,target=/trick \
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
        var/cache/debconf/config.dat \
    && \
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

### 3. prevent kube-proxy setup nf_conntrack_max

```shell
root@kubernetes-1-19-1:~# kubectl logs -n kube-system kube-proxy-6snzq
I1206 03:37:46.513843       1 node.go:136] Successfully retrieved node IP: 10.0.2.16
I1206 03:37:46.513883       1 server_others.go:111] kube-proxy node IP is an IPv4 address (10.0.2.16), assume IPv4 operation
I1206 03:37:46.543672       1 server_others.go:186] Using iptables Proxier.
I1206 03:37:46.543907       1 server.go:650] Version: v1.19.1
I1206 03:37:46.544288       1 conntrack.go:100] Set sysctl 'net/netfilter/nf_conntrack_max' to 131072
F1206 03:37:46.545000       1 server.go:495] open /proc/sys/net/netfilter/nf_conntrack_max: permission denied
```

```yaml
apiVersion: kubeproxy.config.k8s.io/v1alpha1
iptables:
  minSyncPeriod: 1s
kind: KubeProxyConfiguration
mode: iptables
conntrack:
  maxPerCore: 0
```