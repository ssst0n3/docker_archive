# kubernetes v1.23.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.23.0-calico -> ssst0n3/docker_archive:kubernetes-v1.23.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.23.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.23.0-calico
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
NAMESPACE          NAME                                        READY   STATUS    RESTARTS      AGE
calico-apiserver   calico-apiserver-58b9fddf85-bnqqt           1/1     Running   1 (99s ago)   24m
calico-apiserver   calico-apiserver-58b9fddf85-m5chs           1/1     Running   1 (99s ago)   24m
calico-system      calico-kube-controllers-6c4c678f97-mfffg    1/1     Running   1 (99s ago)   25m
calico-system      calico-node-jdhfj                           1/1     Running   1 (99s ago)   25m
calico-system      calico-typha-648469789-w8hzd                1/1     Running   2 (57s ago)   25m
kube-system        coredns-64897985d-h6nsc                     1/1     Running   1 (99s ago)   23h
kube-system        coredns-64897985d-ljp9w                     1/1     Running   1 (99s ago)   23h
kube-system        etcd-kubernetes-1-23-0                      1/1     Running   2 (99s ago)   23h
kube-system        kube-apiserver-kubernetes-1-23-0            1/1     Running   2 (99s ago)   23h
kube-system        kube-controller-manager-kubernetes-1-23-0   1/1     Running   2 (99s ago)   23h
kube-system        kube-proxy-c867l                            1/1     Running   2 (99s ago)   23h
kube-system        kube-scheduler-kubernetes-1-23-0            1/1     Running   2 (99s ago)   23h
tigera-operator    tigera-operator-86dc5fbc67-lttwt            1/1     Running   1 (99s ago)   26m
```

```shell
$ ./ssh
root@kubernetes-1-23-0:~# helm version
version.BuildInfo{Version:"v3.8.0", GitCommit:"d14138609b01886f544b2025f5000351c9eb092e", GitTreeState:"clean", GoVersion:"go1.17.5"}
root@kubernetes-1-23-0:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.0", GitCommit:"ab69524f795c42094a6630298ff53f3c3ebab7f4", GitTreeState:"clean", BuildDate:"2021-12-07T18:16:20Z", GoVersion:"go1.17.3", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.0", GitCommit:"ab69524f795c42094a6630298ff53f3c3ebab7f4", GitTreeState:"clean", BuildDate:"2021-12-07T18:09:57Z", GoVersion:"go1.17.3", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-23-0:~# containerd --version
containerd github.com/containerd/containerd v1.5.2 36cc874494a56a253cd181a1a685b44b58a2e34a
root@kubernetes-1-23-0:~# runc --version
runc version 1.0.0-rc95
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
root@kubernetes-1-23-0:~# cat /etc/os-release
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
root@kubernetes-1-23-0:~# uname -a
Linux kubernetes-1-23-0 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.23.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.23.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug

