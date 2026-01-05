# kubernetes v1.32.2 with containerd v2.0.3, calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3-calico -> ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.32.2_containerd-v2.0.3-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                                         READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-5dc89f5b8b-hn4bf                            1/1     Running   1 (2m55s ago)   93m
calico-apiserver   calico-apiserver-5dc89f5b8b-njghp                            1/1     Running   1 (2m55s ago)   93m
calico-system      calico-kube-controllers-54b679fb89-x4ql6                     1/1     Running   1 (2m55s ago)   93m
calico-system      calico-node-jn8mw                                            1/1     Running   1 (2m55s ago)   93m
calico-system      calico-typha-d548cd4f8-b74xq                                 1/1     Running   1 (2m55s ago)   93m
calico-system      csi-node-driver-9rtw6                                        2/2     Running   2 (2m55s ago)   93m
kube-system        coredns-668d6bf9bc-9shxm                                     1/1     Running   1 (2m55s ago)   139m
kube-system        coredns-668d6bf9bc-bjng9                                     1/1     Running   1 (2m55s ago)   139m
kube-system        etcd-kubernetes-1-32-2-containerd-2-0-3                      1/1     Running   2 (2m55s ago)   139m
kube-system        kube-apiserver-kubernetes-1-32-2-containerd-2-0-3            1/1     Running   2 (2m55s ago)   139m
kube-system        kube-controller-manager-kubernetes-1-32-2-containerd-2-0-3   1/1     Running   2 (2m55s ago)   139m
kube-system        kube-proxy-pwv8p                                             1/1     Running   2 (2m55s ago)   139m
kube-system        kube-scheduler-kubernetes-1-32-2-containerd-2-0-3            1/1     Running   2 (2m55s ago)   139m
tigera-operator    tigera-operator-d77bd6f45-qk7kl                              1/1     Running   1 (2m55s ago)   93m
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
root@kubernetes-1-32-2-containerd-2-0-3:~# helm version
version.BuildInfo{Version:"v3.16.4", GitCommit:"7877b45b63f95635153b29a42c0c2f4273ec45ca", GitTreeState:"clean", GoVersion:"go1.22.7"}
root@kubernetes-1-32-2-containerd-2-0-3:~# kubectl version
Client Version: v1.32.2
Kustomize Version: v5.5.0
Server Version: v1.32.2
root@kubernetes-1-32-2-containerd-2-0-3:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.3 06b99ca80cdbfbc6cc8bd567021738c9af2b36ce
root@kubernetes-1-32-2-containerd-2-0-3:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@kubernetes-1-32-2-containerd-2-0-3:~# cat /etc/os-release 
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
root@kubernetes-1-32-2-containerd-2-0-3:~# uname -a
Linux kubernetes-1-32-2-containerd-2-0-3 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.32.2_containerd-v2.0.3-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
