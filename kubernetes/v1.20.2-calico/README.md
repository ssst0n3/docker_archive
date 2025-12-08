# kubernetes v1.20.2 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.20.2-calico -> ssst0n3/docker_archive:kubernetes-v1.20.2-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.20.2-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.20.2-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.20.2-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.20.2-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.20.2-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE         NAME                                        READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-7c997dbf59-bptfj    1/1     Running   1          30m
calico-system     calico-node-q648z                           1/1     Running   1          30m
calico-system     calico-typha-6db8f5f4f8-sqz9b               1/1     Running   1          30m
kube-system       coredns-74ff55c5b-7gfpn                     1/1     Running   1          40m
kube-system       coredns-74ff55c5b-dckgq                     1/1     Running   1          40m
kube-system       etcd-kubernetes-1-20-2                      1/1     Running   2          40m
kube-system       kube-apiserver-kubernetes-1-20-2            1/1     Running   2          40m
kube-system       kube-controller-manager-kubernetes-1-20-2   1/1     Running   2          40m
kube-system       kube-proxy-p4tc6                            1/1     Running   2          40m
kube-system       kube-scheduler-kubernetes-1-20-2            1/1     Running   2          40m
tigera-operator   tigera-operator-587b8f5c8f-z2wsv            1/1     Running   1          30m
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
root@kubernetes-1-20-2:~# helm version
version.BuildInfo{Version:"v3.5.0", GitCommit:"32c22239423b3b4ba6706d450bd044baffdcf9e6", GitTreeState:"clean", GoVersion:"go1.15.6"}
root@kubernetes-1-20-2:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.2", GitCommit:"faecb196815e248d3ecfb03c680a4507229c2a56", GitTreeState:"clean", BuildDate:"2021-01-13T13:28:09Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.2", GitCommit:"faecb196815e248d3ecfb03c680a4507229c2a56", GitTreeState:"clean", BuildDate:"2021-01-13T13:20:00Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-20-2:~# containerd --version
containerd github.com/containerd/containerd v1.4.0 09814d48d50816305a8e6c1a4ae3e2bcc4ba725a
root@kubernetes-1-20-2:~# runc --version
runc version 1.0.0-rc92
spec: 1.0.2-dev
root@kubernetes-1-20-2:~# uname -a
Linux kubernetes-1-20-2 5.4.0-216-generic #236-Ubuntu SMP Fri Apr 11 19:53:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-20-2:~# cat /etc/os-release 
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
make all DIR=kubernetes/v1.20.2-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.20.2-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
