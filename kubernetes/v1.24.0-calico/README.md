# kubernetes v1.24.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.24.0-calico -> ssst0n3/docker_archive:kubernetes-v1.24.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.24.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.24.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.24.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.24.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.24.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          89s
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-57566ccf67-njq99           1/1     Running   1 (2m47s ago)   157m
calico-apiserver   calico-apiserver-57566ccf67-nrn2h           1/1     Running   1 (2m47s ago)   157m
calico-system      calico-kube-controllers-7cd8b89887-q5zm4    1/1     Running   1 (2m47s ago)   159m
calico-system      calico-node-vfdv9                           1/1     Running   1 (156m ago)    159m
calico-system      calico-typha-7fdfbfb844-nqnt4               1/1     Running   1 (156m ago)    159m
calico-system      csi-node-driver-j7l6k                       2/2     Running   2 (2m47s ago)   158m
kube-system        coredns-6d4b75cb6d-64npc                    1/1     Running   1 (156m ago)    9h
kube-system        coredns-6d4b75cb6d-rmdkl                    1/1     Running   1 (156m ago)    9h
kube-system        etcd-kubernetes-1-24-0                      1/1     Running   2 (2m47s ago)   9h
kube-system        kube-apiserver-kubernetes-1-24-0            1/1     Running   2 (156m ago)    9h
kube-system        kube-controller-manager-kubernetes-1-24-0   1/1     Running   2 (156m ago)    9h
kube-system        kube-proxy-nzbhw                            1/1     Running   2 (156m ago)    9h
kube-system        kube-scheduler-kubernetes-1-24-0            1/1     Running   2 (156m ago)    9h
tigera-operator    tigera-operator-6c49dc8ddf-ssn8j            1/1     Running   2 (2m11s ago)   159m
```

```shell
$ ./ssh
root@kubernetes-1-24-0:~# helm version
version.BuildInfo{Version:"v3.9.0", GitCommit:"7ceeda6c585217a19a1131663d8cd1f7d641b2a7", GitTreeState:"clean", GoVersion:"go1.17.5"}
root@kubernetes-1-24-0:~# kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"24", GitVersion:"v1.24.0", GitCommit:"4ce5a8954017644c5420bae81d72b09b735c21f0", GitTreeState:"clean", BuildDate:"2022-05-03T13:46:05Z", GoVersion:"go1.18.1", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.4
Server Version: version.Info{Major:"1", Minor:"24", GitVersion:"v1.24.0", GitCommit:"4ce5a8954017644c5420bae81d72b09b735c21f0", GitTreeState:"clean", BuildDate:"2022-05-03T13:38:19Z", GoVersion:"go1.18.1", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-24-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.4 212e8b6fa2f44b9c21b2798135fc6fb7c53efc16
root@kubernetes-1-24-0:~# runc --version
runc version 1.0.0-rc95
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
root@kubernetes-1-24-0:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="20.04.6 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.6 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
root@kubernetes-1-24-0:~# uname -a
Linux kubernetes-1-24-0 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.24.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.24.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
