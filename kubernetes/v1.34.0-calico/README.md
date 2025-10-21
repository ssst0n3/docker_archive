# kubernetes v1.34.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.34.0-calico -> ssst0n3/docker_archive:kubernetes-v1.34.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.34.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.34.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ until kubectl --kubeconfig=kubeconfig wait --for=condition=Ready pod --all -A --timeout=30s; do sleep 10; done
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-579759b474-6rswk           1/1     Running   1 (2m7s ago)   9m37s
calico-apiserver   calico-apiserver-579759b474-zmbqq           1/1     Running   1 (2m7s ago)   9m37s
calico-system      calico-kube-controllers-6849dd4d4d-4ptxs    1/1     Running   1 (2m7s ago)   9m34s
calico-system      calico-node-kcp7f                           1/1     Running   1 (2m7s ago)   9m34s
calico-system      calico-typha-669dd47f87-t2fz6               1/1     Running   1 (2m7s ago)   9m34s
calico-system      csi-node-driver-ggstd                       2/2     Running   2 (2m7s ago)   9m34s
calico-system      goldmane-64654bd66b-5xwtb                   1/1     Running   1 (2m7s ago)   9m36s
calico-system      whisker-c64c58759-c86jx                     2/2     Running   2 (2m7s ago)   8m44s
kube-system        coredns-66bc5c9577-rgvzm                    1/1     Running   1 (2m7s ago)   45m
kube-system        coredns-66bc5c9577-wv9sq                    1/1     Running   1 (2m7s ago)   45m
kube-system        etcd-kubernetes-1-34-0                      1/1     Running   2 (2m7s ago)   45m
kube-system        kube-apiserver-kubernetes-1-34-0            1/1     Running   2 (2m7s ago)   45m
kube-system        kube-controller-manager-kubernetes-1-34-0   1/1     Running   2 (2m7s ago)   45m
kube-system        kube-proxy-p5l9m                            1/1     Running   2 (2m7s ago)   45m
kube-system        kube-scheduler-kubernetes-1-34-0            1/1     Running   2 (2m7s ago)   45m
tigera-operator    tigera-operator-65cdcdfd6d-b4hgd            1/1     Running   1 (2m7s ago)   9m51s
```


```shell
$ ./ssh
root@kubernetes-1-34-0:~# helm version
version.BuildInfo{Version:"v3.19.0", GitCommit:"3d8990f0836691f0229297773f3524598f46bda6", GitTreeState:"clean", GoVersion:"go1.24.7"}
root@kubernetes-1-34-0:~# kubectl version
Client Version: v1.34.0
Kustomize Version: v5.7.1
Server Version: v1.34.0
root@kubernetes-1-34-0:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.4 75cb2b7193e4e490e9fbdc236c0e811ccaba3376
root@kubernetes-1-34-0:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@kubernetes-1-34-0:~# uname -a
Linux kubernetes-1-34-0 6.8.0-86-generic #87-Ubuntu SMP PREEMPT_DYNAMIC Mon Sep 22 18:03:36 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-34-0:~# cat /etc/os-release
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
```

## build

```shell
make all DIR=kubernetes/v1.34.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
