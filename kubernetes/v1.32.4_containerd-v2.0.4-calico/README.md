# kubernetes v1.32.4 with containerd v2.0.4, calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.32.4_containerd-v2.0.4-calico -> ssst0n3/docker_archive:kubernetes-v1.32.4_containerd-v2.0.4-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.32.4_containerd-v2.0.4-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.4_containerd-v2.0.4-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.32.4_containerd-v2.0.4-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.4_containerd-v2.0.4-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.32.4_containerd-v2.0.4-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                                         READY   STATUS    RESTARTS      AGE
calico-apiserver   calico-apiserver-5fdddbd779-j59z9                            1/1     Running   1 (11m ago)   162m
calico-apiserver   calico-apiserver-5fdddbd779-zjgjp                            1/1     Running   1 (11m ago)   162m
calico-system      calico-kube-controllers-7c487cb7bf-gwwx8                     1/1     Running   1 (11m ago)   162m
calico-system      calico-node-rswmn                                            1/1     Running   1 (11m ago)   162m
calico-system      calico-typha-57db46b9d7-t846t                                1/1     Running   1 (11m ago)   162m
calico-system      csi-node-driver-4867m                                        2/2     Running   2 (11m ago)   162m
kube-system        coredns-668d6bf9bc-chhxj                                     1/1     Running   1 (11m ago)   3h
kube-system        coredns-668d6bf9bc-ftcr6                                     1/1     Running   1 (11m ago)   3h
kube-system        etcd-kubernetes-1-32-4-containerd-2-0-4                      1/1     Running   2 (11m ago)   3h
kube-system        kube-apiserver-kubernetes-1-32-4-containerd-2-0-4            1/1     Running   2 (11m ago)   3h
kube-system        kube-controller-manager-kubernetes-1-32-4-containerd-2-0-4   1/1     Running   2 (11m ago)   3h
kube-system        kube-proxy-x6cqt                                             1/1     Running   2 (11m ago)   3h
kube-system        kube-scheduler-kubernetes-1-32-4-containerd-2-0-4            1/1     Running   2 (11m ago)   3h
tigera-operator    tigera-operator-d77bd6f45-v7zcn                              1/1     Running   1 (11m ago)   162m
```

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          39s
```

```shell
$ ./ssh
root@kubernetes-1-32-4-containerd-2-0-4:~# helm version
version.BuildInfo{Version:"v3.16.4", GitCommit:"7877b45b63f95635153b29a42c0c2f4273ec45ca", GitTreeState:"clean", GoVersion:"go1.22.7"}
root@kubernetes-1-32-4-containerd-2-0-4:~# kubectl version
Client Version: v1.32.4
Kustomize Version: v5.5.0
Server Version: v1.32.4
root@kubernetes-1-32-4-containerd-2-0-4:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.4 1a43cb6a1035441f9aca8f5666a9b3ef9e70ab20
root@kubernetes-1-32-4-containerd-2-0-4:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@kubernetes-1-32-4-containerd-2-0-4:~# cat /etc/os-release
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
root@kubernetes-1-32-4-containerd-2-0-4:~# uname -a
Linux kubernetes-1-32-4-containerd-2-0-4 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.32.4_containerd-v2.0.4-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.32.4_containerd-v2.0.4-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
