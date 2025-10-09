# kubernetes v1.33.1

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.1 -> ssst0n3/docker_archive:kubernetes-v1.33.1_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1 -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.1_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1_v0.1.0

## usage

```shell
$ cd kubernetes/v1.33.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ until kubectl --kubeconfig=kubeconfig wait --for=condition=Ready pod --all -A --timeout=30s; do sleep 10; done
$ kubectl --kubeconfig=kubeconfig get pods -A                 
NAMESPACE     NAME                                        READY   STATUS    RESTARTS        AGE
kube-system   coredns-674b8bbfcf-bz69g                    0/1     Pending   0               136m
kube-system   coredns-674b8bbfcf-f2k2f                    0/1     Pending   0               136m
kube-system   etcd-kubernetes-1-33-1                      1/1     Running   1 (2m17s ago)   136m
kube-system   kube-apiserver-kubernetes-1-33-1            1/1     Running   2 (2m17s ago)   136m
kube-system   kube-controller-manager-kubernetes-1-33-1   1/1     Running   1 (2m17s ago)   136m
kube-system   kube-proxy-s4qzw                            1/1     Running   1 (2m17s ago)   136m
kube-system   kube-scheduler-kubernetes-1-33-1            1/1     Running   1 (2m17s ago)   136m
```

```shell
$ ./ssh
root@kubernetes-1-33-1:~# helm version
version.BuildInfo{Version:"v3.18.3", GitCommit:"6838ebcf265a3842d1433956e8a622e3290cf324", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-1:~# kubectl version
Client Version: v1.33.1
Kustomize Version: v5.6.0
Server Version: v1.33.1
root@kubernetes-1-33-1:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.0 061792f0ecf3684fb30a3a0eb006799b8c6638a7
root@kubernetes-1-33-1:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@kubernetes-1-33-1:~# uname -a
Linux kubernetes-1-33-1 6.8.0-63-generic #66-Ubuntu SMP PREEMPT_DYNAMIC Fri Jun 13 20:25:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-33-1:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.33.1
```


### for developers

```dockerfile
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.1_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
