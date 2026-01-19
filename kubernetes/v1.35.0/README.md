# kubernetes v1.35.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.35.0 -> ssst0n3/docker_archive:kubernetes-v1.35.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.35.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.35.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.35.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.35.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.35.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=30s
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE     NAME                                        READY   STATUS    RESTARTS      AGE
kube-system   coredns-7d764666f9-kmph5                    0/1     Pending   0             11m
kube-system   coredns-7d764666f9-nfw5f                    0/1     Pending   0             11m
kube-system   etcd-kubernetes-1-35-0                      1/1     Running   1 (83s ago)   11m
kube-system   kube-apiserver-kubernetes-1-35-0            1/1     Running   1 (83s ago)   11m
kube-system   kube-controller-manager-kubernetes-1-35-0   1/1     Running   1 (83s ago)   11m
kube-system   kube-proxy-qlqkj                            1/1     Running   1 (83s ago)   11m
kube-system   kube-scheduler-kubernetes-1-35-0            1/1     Running   1 (83s ago)   11m
```

```shell
$ ./ssh
root@kubernetes-1-35-0:~# helm version
version.BuildInfo{Version:"v4.0.4", GitCommit:"8650e1dad9e6ae38b41f60b712af9218a0d8cc11", GitTreeState:"clean", GoVersion:"go1.25.5", KubeClientVersion:"v1.34"}
root@kubernetes-1-35-0:~# kubectl version
Client Version: v1.35.0
Kustomize Version: v5.7.1
Server Version: v1.35.0
root@kubernetes-1-35-0:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.2.0 1c4457e00facac03ce1d75f7b6777a7a851e5c41
root@kubernetes-1-35-0:~# runc --version
runc version 1.3.3
commit: v1.3.3-0-gd842d771
spec: 1.2.1
go: go1.23.12
libseccomp: 2.5.6
root@kubernetes-1-35-0:~# uname -a
Linux kubernetes-1-35-0 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-35-0:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.35.0
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.35.0_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
