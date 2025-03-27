# kubernetes v1.32.3

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.32.3 -> ssst0n3/docker_archive:kubernetes-v1.32.3_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.32.3_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.3 -> ssst0n3/docker_archive:ctr_kubernetes-v1.32.3_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.3_v0.1.0

## usage

```shell
cd kubernetes/v1.32.3
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@kind-control-plane:~# kubectl version
Client Version: v1.32.3
Kustomize Version: v5.5.0
Server Version: v1.32.3
root@kind-control-plane:~# kubectl get pods -A
NAMESPACE     NAME                                         READY   STATUS    RESTARTS      AGE
kube-system   coredns-668d6bf9bc-cdxj9                     0/1     Pending   0             6m48s
kube-system   coredns-668d6bf9bc-wn4jh                     0/1     Pending   0             6m48s
kube-system   etcd-kind-control-plane                      1/1     Running   1 (96s ago)   6m52s
kube-system   kube-apiserver-kind-control-plane            1/1     Running   3 (96s ago)   6m52s
kube-system   kube-controller-manager-kind-control-plane   1/1     Running   1 (96s ago)   6m52s
kube-system   kube-proxy-2n58g                             1/1     Running   1 (96s ago)   6m48s
kube-system   kube-scheduler-kind-control-plane            1/1     Running   1 (96s ago)   6m52s
```

```shell
root@kind-control-plane:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.3 06b99ca80cdbfbc6cc8bd567021738c9af2b36ce
root@kind-control-plane:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@kind-control-plane:~# uname -a
Linux kind-control-plane 6.8.0-56-generic #58-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb 14 15:33:28 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kind-control-plane:~# cat /etc/os-release 
PRETTY_NAME="Ubuntu 24.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.1 LTS (Noble Numbat)"
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
make all DIR=kubernetes/v1.32.3
```


### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.32.3_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands