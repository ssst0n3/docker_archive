# kubernetes v1.18.2 cluster

master:

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.18.2-master -> ssst0n3/docker_archive:kubernetes-v1.18.2-master_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.18.2-master_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-master -> ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-master_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-master_v0.1.0

worker:

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.18.2-worker -> ssst0n3/docker_archive:kubernetes-v1.18.2-worker_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.18.2-worker_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-worker -> ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-worker_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-worker_v0.1.0


## usage

```shell
$ cd kubernetes/v1.18.2-cluster
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get nodes -o wide
NAME                       STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
kubernetes-1-34-0          Ready    control-plane   8h    v1.34.0   10.0.2.16     <none>        Ubuntu 24.04.2 LTS   6.8.0-86-generic   containerd://2.1.4
kubernetes-1-34-0-worker   Ready    <none>          12m   v1.34.0   10.0.2.17     <none>        Ubuntu 24.04.2 LTS   6.8.0-86-generic   containerd://2.1.4
$ kubectl --kubeconfig=kubeconfig get pods -A      
NAMESPACE         NAME                                        READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-57f767d97b-k895s    1/1     Running   2          3h22m
calico-system     calico-node-hh5lf                           1/1     Running   0          19m
calico-system     calico-node-rj4b5                           0/1     Running   2          3h22m
calico-system     calico-typha-58d98468d6-tqwgk               1/1     Running   4          3h22m
kube-system       coredns-66bff467f8-47gvn                    1/1     Running   2          3h35m
kube-system       coredns-66bff467f8-ztcgw                    1/1     Running   2          3h35m
kube-system       etcd-kubernetes-1-18-2                      1/1     Running   3          3h36m
kube-system       kube-apiserver-kubernetes-1-18-2            1/1     Running   3          3h36m
kube-system       kube-controller-manager-kubernetes-1-18-2   1/1     Running   3          3h36m
kube-system       kube-proxy-cz2gt                            1/1     Running   0          19m
kube-system       kube-proxy-n2xtn                            1/1     Running   3          3h35m
kube-system       kube-scheduler-kubernetes-1-18-2            1/1     Running   3          3h36m
tigera-operator   tigera-operator-6ddb54fbf5-ppb6x            1/1     Running   4          3h22m
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

execute and wait until `[10570.630877] [master] Waiting for at least one worker node to become Ready.` in the dmesg

```shell
make all DIR=kubernetes/v1.34.0-cluster/master
```

and then execute:

```shell
make all DIR=kubernetes/v1.34.0-cluster/worker
```


### for developers

#### master

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-master_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug

#### worker

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-worker_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.17 to debug
