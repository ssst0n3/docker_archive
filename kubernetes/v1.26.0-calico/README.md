# kubernetes v1.26.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.26.0-calico -> ssst0n3/docker_archive:kubernetes-v1.26.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.26.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.26.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.26.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.26.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.26.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS       AGE
calico-apiserver   calico-apiserver-598f55ff4c-cl5qd           1/1     Running   1 (108s ago)   32m
calico-apiserver   calico-apiserver-598f55ff4c-zsctw           1/1     Running   1 (108s ago)   32m
calico-system      calico-kube-controllers-84dd694985-cqr5d    1/1     Running   1 (108s ago)   34m
calico-system      calico-node-kjg4p                           1/1     Running   1 (108s ago)   34m
calico-system      calico-typha-58465557df-fwstg               1/1     Running   1 (108s ago)   34m
calico-system      csi-node-driver-5x6cp                       2/2     Running   2 (108s ago)   34m
kube-system        coredns-787d4945fb-btn76                    1/1     Running   1 (108s ago)   57m
kube-system        coredns-787d4945fb-c4fng                    1/1     Running   1 (108s ago)   57m
kube-system        etcd-kubernetes-1-26-0                      1/1     Running   2 (108s ago)   57m
kube-system        kube-apiserver-kubernetes-1-26-0            1/1     Running   2 (108s ago)   57m
kube-system        kube-controller-manager-kubernetes-1-26-0   1/1     Running   2 (108s ago)   57m
kube-system        kube-proxy-ntv4t                            1/1     Running   2 (108s ago)   57m
kube-system        kube-scheduler-kubernetes-1-26-0            1/1     Running   2 (108s ago)   57m
tigera-operator    tigera-operator-66654c8696-zggbt            1/1     Running   2 (60s ago)    34m
```

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          9m14s
```

```shell
$ ./ssh
root@kubernetes-1-26-0:~# helm version
version.BuildInfo{Version:"v3.11.0", GitCommit:"472c5736ab01133de504a826bd9ee12cbe4e7904", GitTreeState:"clean", GoVersion:"go1.18.10"}
root@kubernetes-1-26-0:~# kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.0", GitCommit:"b46a3f887ca979b1a5d14fd39cb1af43e7e5d12d", GitTreeState:"clean", BuildDate:"2022-12-08T19:58:30Z", GoVersion:"go1.19.4", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.0", GitCommit:"b46a3f887ca979b1a5d14fd39cb1af43e7e5d12d", GitTreeState:"clean", BuildDate:"2022-12-08T19:51:45Z", GoVersion:"go1.19.4", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-26-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.9 1c90a442489720eec95342e1789ee8a5e1b9536f
root@kubernetes-1-26-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@kubernetes-1-26-0:~# cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
root@kubernetes-1-26-0:~# uname -a
Linux kubernetes-1-26-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.26.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.26.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
