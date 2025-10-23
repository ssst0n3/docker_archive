# kubernetes v1.18.2 cluster

master:

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.18.2-master -> ssst0n3/docker_archive:kubernetes-v1.18.2-master_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.18.2-master_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-master -> ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-master_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-master_v0.1.0

worker:

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.18.2-worker -> ssst0n3/docker_archive:kubernetes-v1.18.2-worker_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.18.2-worker_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-worker -> ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-worker_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-worker_v0.1.0


## usage

```shell
$ cd kubernetes/v1.18.2-cluster
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get nodes -o wide
NAME                       STATUS   ROLES    AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
kubernetes-1-18-2          Ready    master   3h57m   v1.18.2   10.0.2.16     <none>        Ubuntu 20.04.6 LTS   5.4.0-216-generic   containerd://1.3.3
kubernetes-1-18-2-worker   Ready    <none>   15m     v1.18.2   <none>        <none>        Ubuntu 20.04.6 LTS   5.4.0-216-generic   containerd://1.3.3
$ kubectl --kubeconfig=kubeconfig get pods -A      
NAMESPACE         NAME                                        READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-57f767d97b-k895s    1/1     Running   2          3h43m
calico-system     calico-node-rj4b5                           1/1     Running   2          3h43m
calico-system     calico-node-rn2dh                           1/1     Running   1          15m
calico-system     calico-typha-58d98468d6-tqwgk               1/1     Running   3          3h43m
kube-system       coredns-66bff467f8-47gvn                    1/1     Running   2          3h57m
kube-system       coredns-66bff467f8-ztcgw                    1/1     Running   2          3h57m
kube-system       etcd-kubernetes-1-18-2                      1/1     Running   3          3h57m
kube-system       kube-apiserver-kubernetes-1-18-2            1/1     Running   3          3h57m
kube-system       kube-controller-manager-kubernetes-1-18-2   1/1     Running   3          3h57m
kube-system       kube-proxy-8lhf9                            1/1     Running   1          15m
kube-system       kube-proxy-n2xtn                            1/1     Running   3          3h57m
kube-system       kube-scheduler-kubernetes-1-18-2            1/1     Running   3          3h57m
tigera-operator   tigera-operator-6ddb54fbf5-ppb6x            1/1     Running   4          3h43m
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

execute and wait until `[10570.630877] [master] Waiting for at least one worker node to become Ready.` in the dmesg

```shell
make all DIR=kubernetes/v1.18.2-cluster/master
```

and then execute:

```shell
make all DIR=kubernetes/v1.18.2-cluster/worker
```


### for developers

#### master

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-master_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug

#### worker

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.18.2-worker_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.17 to debug
