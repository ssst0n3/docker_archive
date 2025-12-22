# kubernetes v1.22.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.22.0-calico -> ssst0n3/docker_archive:kubernetes-v1.22.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.22.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.22.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.22.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.22.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.22.0-calico
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
calico-apiserver   calico-apiserver-9499956d-67tnf             1/1     Running   1 (21h ago)   21h
calico-apiserver   calico-apiserver-9499956d-xf5mn             1/1     Running   1 (21h ago)   21h
calico-system      calico-kube-controllers-77b5cb49c9-t9p89    1/1     Running   1 (21h ago)   21h
calico-system      calico-node-mgwp8                           1/1     Running   1 (21h ago)   21h
calico-system      calico-typha-6bc548dbd6-g5jxw               1/1     Running   1 (21h ago)   21h
kube-system        coredns-78fcd69978-lcckw                    1/1     Running   1 (21h ago)   33h
kube-system        coredns-78fcd69978-tsllm                    1/1     Running   1 (21h ago)   33h
kube-system        etcd-kubernetes-1-22-0                      1/1     Running   2 (21h ago)   33h
kube-system        kube-apiserver-kubernetes-1-22-0            1/1     Running   2 (21h ago)   33h
kube-system        kube-controller-manager-kubernetes-1-22-0   1/1     Running   2 (21h ago)   33h
kube-system        kube-proxy-xv9sl                            1/1     Running   2 (21h ago)   33h
kube-system        kube-scheduler-kubernetes-1-22-0            1/1     Running   2 (21h ago)   33h
tigera-operator    tigera-operator-6fdc4c585-788w9             1/1     Running   2 (21h ago)   21h
```

```shell
$ ./ssh
root@kubernetes-1-22-0:~# helm version
version.BuildInfo{Version:"v3.7.0", GitCommit:"eeac83883cb4014fe60267ec6373570374ce770b", GitTreeState:"clean", GoVersion:"go1.16.8"}
root@kubernetes-1-22-0:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"22", GitVersion:"v1.22.0", GitCommit:"c2b5237ccd9c0f1d600d3072634ca66cefdf272f", GitTreeState:"clean", BuildDate:"2021-08-04T18:03:20Z", GoVersion:"go1.16.6", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"22", GitVersion:"v1.22.0", GitCommit:"c2b5237ccd9c0f1d600d3072634ca66cefdf272f", GitTreeState:"clean", BuildDate:"2021-08-04T17:57:25Z", GoVersion:"go1.16.6", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-22-0:~# containerd --version
containerd github.com/containerd/containerd v1.5.2 36cc874494a56a253cd181a1a685b44b58a2e34a
root@kubernetes-1-22-0:~# runc --version
runc version 1.0.0-rc95
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
root@kubernetes-1-22-0:~# cat /etc/os-release 
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
root@kubernetes-1-22-0:~# uname -a
Linux kubernetes-1-22-0 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.22.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.22.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug

