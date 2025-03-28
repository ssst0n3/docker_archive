# kubernetes v1.32.2 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.32.2-calico -> ssst0n3/docker_archive:kubernetes-v1.32.2-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.32.2-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.32.2-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2-calico_v0.1.0

## usage

```shell
cd kubernetes/v1.32.2-calico
docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
./ssh
```

```shell
root@kind-control-plane:~# kubectl version
Client Version: v1.32.2
Kustomize Version: v5.5.0
Server Version: v1.32.2
root@kind-control-plane:~# kubectl get pods -A
NAMESPACE          NAME                                         READY   STATUS    RESTARTS      AGE
calico-apiserver   calico-apiserver-5bbbcb4ffc-8ksds            1/1     Running   1 (72s ago)   19m
calico-apiserver   calico-apiserver-5bbbcb4ffc-t4wfk            1/1     Running   1 (72s ago)   19m
calico-system      calico-kube-controllers-7f5fc84799-5jdxw     1/1     Running   1 (72s ago)   19m
calico-system      calico-node-8t7vd                            1/1     Running   1 (72s ago)   19m
calico-system      calico-typha-87996898f-7d9pc                 1/1     Running   1 (72s ago)   19m
calico-system      csi-node-driver-zmpmb                        2/2     Running   2 (72s ago)   19m
kube-system        coredns-668d6bf9bc-dcc4l                     1/1     Running   1 (72s ago)   3h24m
kube-system        coredns-668d6bf9bc-zhwn7                     1/1     Running   1 (72s ago)   3h24m
kube-system        etcd-kind-control-plane                      1/1     Running   2 (72s ago)   3h24m
kube-system        kube-apiserver-kind-control-plane            1/1     Running   2 (72s ago)   3h24m
kube-system        kube-controller-manager-kind-control-plane   1/1     Running   2 (72s ago)   3h24m
kube-system        kube-proxy-bg8tr                             1/1     Running   2 (72s ago)   3h24m
kube-system        kube-scheduler-kind-control-plane            1/1     Running   2 (72s ago)   3h24m
tigera-operator    tigera-operator-ccfc44587-mxqgs              1/1     Running   1 (72s ago)   19m
```

```shell
root@kind-control-plane:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.2 c507a0257ea6462fbd6f5ba4f5c74facb04021f4
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
make all DIR=kubernetes/v1.32.2-calico
```


### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.32.2-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.17 to debug
