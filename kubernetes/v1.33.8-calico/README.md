# kubernetes v1.33.8, with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.8-calico -> ssst0n3/docker_archive:kubernetes-v1.33.8-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.8-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.8-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.8-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.8-calico_v0.1.0

## usage

### startup

```shell
$ cd kubernetes/v1.33.8-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### built-in pods

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS       AGE
calico-apiserver   calico-apiserver-cc8699d98-cpjdw            1/1     Running   1 (4m4s ago)   23m
calico-apiserver   calico-apiserver-cc8699d98-jtfrn            1/1     Running   1 (4m4s ago)   23m
calico-system      calico-kube-controllers-77854948bb-skpt4    1/1     Running   1 (4m4s ago)   22m
calico-system      calico-node-r5k5c                           1/1     Running   1 (4m4s ago)   22m
calico-system      calico-typha-85c7694d7d-gqwlc               1/1     Running   1 (4m3s ago)   22m
calico-system      csi-node-driver-p4t8t                       2/2     Running   2 (4m4s ago)   22m
calico-system      goldmane-b49dd46d7-2v28f                    1/1     Running   1 (4m4s ago)   22m
calico-system      whisker-6476b5d5f8-fv8c6                    2/2     Running   2 (4m3s ago)   22m
kube-system        coredns-674b8bbfcf-26cc8                    1/1     Running   1 (4m3s ago)   168m
kube-system        coredns-674b8bbfcf-l9znm                    1/1     Running   1 (4m3s ago)   168m
kube-system        etcd-kubernetes-1-33-8                      1/1     Running   2 (4m3s ago)   168m
kube-system        kube-apiserver-kubernetes-1-33-8            1/1     Running   2 (4m4s ago)   168m
kube-system        kube-controller-manager-kubernetes-1-33-8   1/1     Running   2 (4m4s ago)   168m
kube-system        kube-proxy-jzkqm                            1/1     Running   2 (4m3s ago)   168m
kube-system        kube-scheduler-kubernetes-1-33-8            1/1     Running   2 (4m4s ago)   168m
tigera-operator    tigera-operator-6d69b9b454-mbpzf            1/1     Running   1 (4m4s ago)   23m
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
root@kubernetes-1-33-8:~# helm version
version.BuildInfo{Version:"v3.18.4", GitCommit:"d80839cf37d860c8aa9a0503fe463278f26cd5e2", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-8:~# kubectl version
Client Version: v1.33.8
Kustomize Version: v5.6.0
Server Version: v1.33.8
root@kubernetes-1-33-8:~# nerdctl --version
nerdctl version 2.2.1
root@kubernetes-1-33-8:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.26.3 c70e8e666f8f6ee3c0d83b20c338be5aedeaa97a
root@kubernetes-1-33-8:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.2.1 dea7da592f5d1d2b7755e3a161be07f43fad8f75
root@kubernetes-1-33-8:~# runc --version
runc version 1.3.4
commit: v1.3.4-0-gd6d73eb8
spec: 1.2.1
go: go1.24.10
libseccomp: 2.5.6
root@kubernetes-1-33-8:~# cat /etc/os-release
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
root@kubernetes-1-33-8:~# uname -a
Linux kubernetes-1-33-8 6.8.0-101-generic #101-Ubuntu SMP PREEMPT_DYNAMIC Mon Feb  9 10:15:05 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.33.8-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.8-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
