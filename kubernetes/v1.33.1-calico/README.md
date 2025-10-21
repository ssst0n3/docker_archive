# kubernetes v1.33.1 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.1-calico -> ssst0n3/docker_archive:kubernetes-v1.33.1-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.1-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.33.1-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ until kubectl --kubeconfig=kubeconfig wait --for=condition=Ready pod --all -A --timeout=30s; do sleep 10; done
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-789bcb55b-cckpl            1/1     Running   1 (2m29s ago)   14m
calico-apiserver   calico-apiserver-789bcb55b-w4zqk            1/1     Running   1 (2m29s ago)   14m
calico-system      calico-kube-controllers-945bcc5f8-p8czx     1/1     Running   1 (2m29s ago)   14m
calico-system      calico-node-zf9qf                           1/1     Running   1 (2m29s ago)   14m
calico-system      calico-typha-7dccd7876b-4596t               1/1     Running   1 (2m29s ago)   14m
calico-system      csi-node-driver-vj6n9                       2/2     Running   2 (2m29s ago)   14m
calico-system      goldmane-86cd9d999d-74dfv                   1/1     Running   1 (2m29s ago)   14m
calico-system      whisker-699cdc85cb-gwsjm                    2/2     Running   2 (2m29s ago)   11m
kube-system        coredns-674b8bbfcf-bz69g                    1/1     Running   1 (2m29s ago)   3h36m
kube-system        coredns-674b8bbfcf-f2k2f                    1/1     Running   1 (2m29s ago)   3h36m
kube-system        etcd-kubernetes-1-33-1                      1/1     Running   2 (2m29s ago)   3h36m
kube-system        kube-apiserver-kubernetes-1-33-1            1/1     Running   3 (2m29s ago)   3h36m
kube-system        kube-controller-manager-kubernetes-1-33-1   1/1     Running   2 (2m29s ago)   3h36m
kube-system        kube-proxy-s4qzw                            1/1     Running   2 (2m29s ago)   3h36m
kube-system        kube-scheduler-kubernetes-1-33-1            1/1     Running   2 (2m29s ago)   3h36m
tigera-operator    tigera-operator-68f7c7984d-vknxx            1/1     Running   1 (2m29s ago)   14m
```


```shell
$ ./ssh
root@kubernetes-1-33-1:~# helm version
version.BuildInfo{Version:"v3.18.3", GitCommit:"6838ebcf265a3842d1433956e8a622e3290cf324", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-1:~# kubectl version
Client Version: v1.33.1
Kustomize Version: v5.6.0
Server Version: v1.33.1
root@kubernetes-1-33-1:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.0 061792f0ecf3684fb30a3a0eb006799b8c6638a7
root@kubernetes-1-33-1:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@kubernetes-1-33-1:~# uname -a
Linux kubernetes-1-33-1 6.8.0-63-generic #66-Ubuntu SMP PREEMPT_DYNAMIC Fri Jun 13 20:25:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-33-1:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.33.1-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
