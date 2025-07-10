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
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-756f76b55d-2bfdm           1/1     Running   1 (3m27s ago)   14m
calico-apiserver   calico-apiserver-756f76b55d-9bwcr           1/1     Running   1 (3m27s ago)   14m
calico-system      calico-kube-controllers-55d4bb6759-8jjr7    1/1     Running   1 (3m27s ago)   14m
calico-system      calico-node-6h69f                           1/1     Running   1 (3m27s ago)   14m
calico-system      calico-typha-c4856f78d-tnqlq                1/1     Running   1 (3m27s ago)   14m
calico-system      csi-node-driver-gs9jj                       2/2     Running   2 (3m27s ago)   14m
calico-system      goldmane-86cd9d999d-7l47v                   1/1     Running   1 (3m27s ago)   14m
calico-system      whisker-d788d88c4-59nmz                     2/2     Running   2 (3m27s ago)   12m
kube-system        coredns-674b8bbfcf-l87fg                    1/1     Running   1 (3m27s ago)   34d
kube-system        coredns-674b8bbfcf-zp9d4                    1/1     Running   1 (3m27s ago)   34d
kube-system        etcd-k8s-control-plane                      1/1     Running   2 (3m27s ago)   34d
kube-system        kube-apiserver-k8s-control-plane            1/1     Running   2 (3m27s ago)   34d
kube-system        kube-controller-manager-k8s-control-plane   1/1     Running   2 (3m27s ago)   34d
kube-system        kube-proxy-q6rb5                            1/1     Running   2 (3m27s ago)   34d
kube-system        kube-scheduler-k8s-control-plane            1/1     Running   2 (3m27s ago)   34d
tigera-operator    tigera-operator-68f7c7984d-tjc4g            1/1     Running   1 (3m27s ago)   14m
```


```shell
$ ./ssh
root@k8s-control-plane:~# kubectl version
Client Version: v1.33.1
Kustomize Version: v5.6.0
Server Version: v1.33.1
root@k8s-control-plane:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.0 061792f0ecf3684fb30a3a0eb006799b8c6638a7
root@k8s-control-plane:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@k8s-control-plane:~# uname -a
Linux k8s-control-plane 6.8.0-63-generic #66-Ubuntu SMP PREEMPT_DYNAMIC Fri Jun 13 20:25:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@k8s-control-plane:~# cat /etc/os-release
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
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
