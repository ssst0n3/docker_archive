# kubernetes v1.32.3 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.32.3-calico -> ssst0n3/docker_archive:kubernetes-v1.32.3-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.32.3-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.3-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.32.3-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.3-calico_v0.1.0

## usage

```shell
cd kubernetes/v1.32.3-calico
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@kind-control-plane:~# kubectl version
Client Version: v1.32.3
Kustomize Version: v5.5.0
Server Version: v1.32.3
root@kind-control-plane:~# kubectl get pods -A
NAMESPACE          NAME                                         READY   STATUS    RESTARTS      AGE
calico-apiserver   calico-apiserver-7f5bc4ff6c-phk8k            1/1     Running   1 (80s ago)   12m
calico-apiserver   calico-apiserver-7f5bc4ff6c-z7x74            1/1     Running   1 (80s ago)   12m
calico-system      calico-kube-controllers-7499b86bff-n9h6b     1/1     Running   1 (80s ago)   12m
calico-system      calico-node-5bk44                            1/1     Running   1 (80s ago)   12m
calico-system      calico-typha-7675b678c7-ld2jn                1/1     Running   1 (80s ago)   12m
calico-system      csi-node-driver-z6vf9                        2/2     Running   2 (80s ago)   12m
kube-system        coredns-668d6bf9bc-cdxj9                     1/1     Running   1 (80s ago)   34m
kube-system        coredns-668d6bf9bc-wn4jh                     1/1     Running   1 (80s ago)   34m
kube-system        etcd-kind-control-plane                      1/1     Running   2 (80s ago)   34m
kube-system        kube-apiserver-kind-control-plane            1/1     Running   4 (80s ago)   34m
kube-system        kube-controller-manager-kind-control-plane   1/1     Running   2 (80s ago)   34m
kube-system        kube-proxy-2n58g                             1/1     Running   2 (80s ago)   34m
kube-system        kube-scheduler-kind-control-plane            1/1     Running   2 (80s ago)   34m
tigera-operator    tigera-operator-789496d6f5-97hhl             1/1     Running   1 (80s ago)   12m
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
make all DIR=kubernetes/v1.32.3-calico
```


### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.32.3-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands