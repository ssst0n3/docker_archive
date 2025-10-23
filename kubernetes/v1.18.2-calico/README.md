# kubernetes v1.18.2 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.18.2-calico -> ssst0n3/docker_archive:kubernetes-v1.18.2-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.18.2-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.18.2-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE         NAME                                        READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-57f767d97b-fcvxn    1/1     Running   1          22m
calico-system     calico-node-gvf7b                           1/1     Running   1          22m
calico-system     calico-typha-759ff4749f-snhqh               1/1     Running   1          22m
kube-system       coredns-66bff467f8-6nfh6                    1/1     Running   1          75m
kube-system       coredns-66bff467f8-vcdk2                    1/1     Running   1          75m
kube-system       etcd-kubernetes-1-18-2                      1/1     Running   2          75m
kube-system       kube-apiserver-kubernetes-1-18-2            1/1     Running   2          75m
kube-system       kube-controller-manager-kubernetes-1-18-2   1/1     Running   2          75m
kube-system       kube-proxy-lk8pg                            1/1     Running   2          75m
kube-system       kube-scheduler-kubernetes-1-18-2            1/1     Running   2          75m
tigera-operator   tigera-operator-6ddb54fbf5-fnrhx            1/1     Running   2          22m
```


```shell
$ ./ssh
root@kubernetes-1-18-2:~# helm version
version.BuildInfo{Version:"v3.2.4", GitCommit:"0ad800ef43d3b826f31a5ad8dfbb4fe05d143688", GitTreeState:"clean", GoVersion:"go1.13.12"}
root@kubernetes-1-18-2:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"52c56ce7a8272c798dbc29846288d7cd9fbae032", GitTreeState:"clean", BuildDate:"2020-04-16T11:56:40Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"52c56ce7a8272c798dbc29846288d7cd9fbae032", GitTreeState:"clean", BuildDate:"2020-04-16T11:48:36Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-18-2:~# containerd --version
containerd github.com/containerd/containerd v1.3.3 d76c121f76a5fc8a462dc64594aea72fe18e1178
root@kubernetes-1-18-2:~# runc --version
runc version 1.0.0-rc10
spec: 1.0.1-dev
root@kubernetes-1-18-2:~# uname -a
Linux kubernetes-1-18-2 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-18-2:~# cat /etc/os-release
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
```

## build

```shell
make all DIR=kubernetes/v1.18.2-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
