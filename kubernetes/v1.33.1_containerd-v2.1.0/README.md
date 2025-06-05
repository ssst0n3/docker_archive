# kubernetes v1.33.1 with containerd v2.1.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.1_containerd-v2.1.0 -> ssst0n3/docker_archive:kubernetes-v1.33.1_containerd-v2.1.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.1_containerd-v2.1.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1_containerd-v2.1.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.1_containerd-v2.1.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1_containerd-v2.1.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.33.1_containerd-v2.1.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS        AGE
kube-system   coredns-674b8bbfcf-l87fg                    0/1     Pending   0               16m
kube-system   coredns-674b8bbfcf-zp9d4                    0/1     Pending   0               16m
kube-system   etcd-k8s-control-plane                      1/1     Running   1 (6m42s ago)   16m
kube-system   kube-apiserver-k8s-control-plane            1/1     Running   1 (6m42s ago)   16m
kube-system   kube-controller-manager-k8s-control-plane   1/1     Running   1 (6m42s ago)   16m
kube-system   kube-proxy-q6rb5                            1/1     Running   1 (6m42s ago)   16m
kube-system   kube-scheduler-k8s-control-plane            1/1     Running   1 (6m42s ago)   16m
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
Linux k8s-control-plane 6.8.0-60-generic #63-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 15 19:04:15 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
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
make all DIR=kubernetes/v1.33.1_containerd-v2.1.0
```


### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_v1.33.1_containerd-v2.1.0_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
