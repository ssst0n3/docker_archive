# kubernetes v1.33.3 with containerd v2.1.2, calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.3_containerd-v2.1.2-calico -> ssst0n3/docker_archive:kubernetes-v1.33.3_containerd-v2.1.2-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.3_containerd-v2.1.2-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.2-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.2-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.2-calico_v0.1.0

## usage

### startup

```shell
$ cd kubernetes/v1.33.3_containerd-v2.1.2-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### built-in pods

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                                         READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-79f98c858f-nbdfd                            1/1     Running   1 (3m55s ago)   15m
calico-apiserver   calico-apiserver-79f98c858f-p7rhp                            1/1     Running   1 (3m56s ago)   15m
calico-system      calico-kube-controllers-794c697d75-pckxz                     1/1     Running   1 (3m56s ago)   15m
calico-system      calico-node-ktsm9                                            1/1     Running   1 (3m56s ago)   15m
calico-system      calico-typha-567cb5895b-gmr7r                                1/1     Running   1 (3m56s ago)   15m
calico-system      csi-node-driver-zgtzm                                        2/2     Running   2 (3m55s ago)   15m
calico-system      goldmane-b49dd46d7-jg9mj                                     1/1     Running   1 (3m56s ago)   15m
calico-system      whisker-7767667678-wh5m5                                     2/2     Running   2 (3m55s ago)   13m
kube-system        coredns-674b8bbfcf-kdrh4                                     1/1     Running   1 (3m56s ago)   59m
kube-system        coredns-674b8bbfcf-wmlkh                                     1/1     Running   1 (3m56s ago)   59m
kube-system        etcd-kubernetes-1-33-3-containerd-2-1-2                      1/1     Running   2 (3m56s ago)   59m
kube-system        kube-apiserver-kubernetes-1-33-3-containerd-2-1-2            1/1     Running   2 (3m56s ago)   59m
kube-system        kube-controller-manager-kubernetes-1-33-3-containerd-2-1-2   1/1     Running   2 (3m56s ago)   59m
kube-system        kube-proxy-jj77m                                             1/1     Running   2 (3m55s ago)   59m
kube-system        kube-scheduler-kubernetes-1-33-3-containerd-2-1-2            1/1     Running   2 (3m55s ago)   59m
tigera-operator    tigera-operator-6d69b9b454-lb5ff                             1/1     Running   1 (3m56s ago)   16m
```

### deploy a pod

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          39s
```

### versions

```shell
$ ./ssh
root@kubernetes-1-33-3-containerd-2-1-2:~# helm version
version.BuildInfo{Version:"v3.18.4", GitCommit:"d80839cf37d860c8aa9a0503fe463278f26cd5e2", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-3-containerd-2-1-2:~# kubectl version
Client Version: v1.33.3
Kustomize Version: v5.6.0
Server Version: v1.33.3
root@kubernetes-1-33-3-containerd-2-1-2:~# nerdctl --version
nerdctl version 2.1.2
root@kubernetes-1-33-3-containerd-2-1-2:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.21.1 66735c67040bc80e6ed104f451683e094030a4e1
root@kubernetes-1-33-3-containerd-2-1-2:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.2 64ed272067a24c2d917064eea25a78e1479d632f
root@kubernetes-1-33-3-containerd-2-1-2:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@kubernetes-1-33-3-containerd-2-1-2:~# cat /etc/os-release
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
root@kubernetes-1-33-3-containerd-2-1-2:~# uname -a
Linux kubernetes-1-33-3-containerd-2-1-2 6.8.0-94-generic #96-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan  9 20:36:55 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.33.3_containerd-v2.1.2-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.3_containerd-v2.1.2-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
