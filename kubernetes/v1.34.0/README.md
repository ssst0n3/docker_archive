# kubernetes v1.34.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.34.0 -> ssst0n3/docker_archive:kubernetes-v1.34.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.34.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.34.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.34.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=30s
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS        AGE
kube-system   coredns-66bc5c9577-kpjdq                    0/1     Pending   0               10m
kube-system   coredns-66bc5c9577-kzppj                    0/1     Pending   0               10m
kube-system   etcd-kubernetes-1-34-0                      1/1     Running   1 (3m47s ago)   10m
kube-system   kube-apiserver-kubernetes-1-34-0            1/1     Running   1 (3m47s ago)   10m
kube-system   kube-controller-manager-kubernetes-1-34-0   1/1     Running   1 (3m47s ago)   10m
kube-system   kube-proxy-gqmnr                            1/1     Running   1 (3m47s ago)   10m
kube-system   kube-scheduler-kubernetes-1-34-0            1/1     Running   1 (3m47s ago)   10m
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
make all DIR=kubernetes/v1.34.0
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.34.0_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
