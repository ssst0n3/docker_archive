# kubernetes v1.28.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.28.0-calico -> ssst0n3/docker_archive:kubernetes-v1.28.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.28.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.28.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.28.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.28.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.28.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE         NAME                                        READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-57f767d97b-k895s    1/1     Running   1          15m
calico-system     calico-node-rj4b5                           1/1     Running   1          15m
calico-system     calico-typha-58d98468d6-tqwgk               1/1     Running   2          15m
kube-system       coredns-66bff467f8-47gvn                    1/1     Running   1          29m
kube-system       coredns-66bff467f8-ztcgw                    1/1     Running   1          29m
kube-system       etcd-kubernetes-1-18-2                      1/1     Running   2          29m
kube-system       kube-apiserver-kubernetes-1-18-2            1/1     Running   2          29m
kube-system       kube-controller-manager-kubernetes-1-18-2   1/1     Running   2          29m
kube-system       kube-proxy-n2xtn                            1/1     Running   2          29m
kube-system       kube-scheduler-kubernetes-1-18-2            1/1     Running   2          29m
tigera-operator   tigera-operator-6ddb54fbf5-ppb6x            1/1     Running   2          15m
```


```shell
$ ./ssh
root@kubernetes-1-28-0:~# helm version
version.BuildInfo{Version:"v3.13.0", GitCommit:"825e86f6a7a38cef1112bfa606e4127a706749b1", GitTreeState:"clean", GoVersion:"go1.20.8"}
root@kubernetes-1-28-0:~# kubectl version
Client Version: v1.28.0
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.28.0
root@kubernetes-1-28-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.21 3dce8eb055cbb6872793272b4f20ed16117344f8
root@kubernetes-1-28-0:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@kubernetes-1-28-0:~# uname -a
Linux kubernetes-1-28-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-28-0:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.28.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.28.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
