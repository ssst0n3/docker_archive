# kubernetes v1.21.1 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.21.1-calico -> ssst0n3/docker_archive:kubernetes-v1.21.1-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.21.1-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.21.1-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.21.1-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.21.1-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.21.1-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE         NAME                                        READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-6d9454449-lcfp8     1/1     Running   1          147m
calico-system     calico-node-x6df2                           1/1     Running   1          147m
calico-system     calico-typha-6c4998d4b6-ddtvl               1/1     Running   1          147m
kube-system       coredns-558bd4d5db-l2btw                    1/1     Running   1          165m
kube-system       coredns-558bd4d5db-ptzxt                    1/1     Running   1          165m
kube-system       etcd-kubernetes-1-21-1                      1/1     Running   2          165m
kube-system       kube-apiserver-kubernetes-1-21-1            1/1     Running   2          165m
kube-system       kube-controller-manager-kubernetes-1-21-1   1/1     Running   2          165m
kube-system       kube-proxy-tp9vv                            1/1     Running   2          165m
kube-system       kube-scheduler-kubernetes-1-21-1            1/1     Running   2          165m
tigera-operator   tigera-operator-5c97d4cbbf-gpsvf            1/1     Running   2          147m
```

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          89s
```

```shell
$ ./ssh
root@kubernetes-1-21-1:~# helm version
version.BuildInfo{Version:"v3.6.0", GitCommit:"7f2df6467771a75f5646b7f12afb408590ed1755", GitTreeState:"clean", GoVersion:"go1.16.3"}
root@kubernetes-1-21-1:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.1", GitCommit:"5e58841cce77d4bc13713ad2b91fa0d961e69192", GitTreeState:"clean", BuildDate:"2021-05-12T14:18:45Z", GoVersion:"go1.16.4", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.1", GitCommit:"5e58841cce77d4bc13713ad2b91fa0d961e69192", GitTreeState:"clean", BuildDate:"2021-05-12T14:12:29Z", GoVersion:"go1.16.4", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-21-1:~# containerd --version
containerd github.com/containerd/containerd v1.5.1 12dca9790f4cb6b18a6a7a027ce420145cb98ee7
root@kubernetes-1-21-1:~# runc --version
runc version 1.0.0-rc94
spec: 1.0.2-dev
go: go1.14.15
libseccomp: 2.5.1
root@kubernetes-1-21-1:~# uname -a
Linux kubernetes-1-21-1 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-21-1:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.21.1-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.21.1-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
