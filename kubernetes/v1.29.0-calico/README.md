# kubernetes v1.29.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.29.0-calico -> ssst0n3/docker_archive:kubernetes-v1.29.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.29.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.29.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.29.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.29.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.29.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS      AGE
calico-apiserver   calico-apiserver-54c894cff5-gf4mk           1/1     Running   1 (78s ago)   12m
calico-apiserver   calico-apiserver-54c894cff5-qf574           1/1     Running   1 (78s ago)   12m
calico-system      calico-kube-controllers-d7cc8d456-84qzx     1/1     Running   1 (78s ago)   15m
calico-system      calico-node-hdj7f                           1/1     Running   1 (78s ago)   15m
calico-system      calico-typha-68d9c76c87-6ts67               1/1     Running   1 (78s ago)   15m
calico-system      csi-node-driver-dx7m2                       2/2     Running   2 (78s ago)   15m
kube-system        coredns-76f75df574-fn8bm                    1/1     Running   1 (78s ago)   32m
kube-system        coredns-76f75df574-fzt2w                    1/1     Running   1 (78s ago)   32m
kube-system        etcd-kubernetes-1-29-0                      1/1     Running   2 (78s ago)   32m
kube-system        kube-apiserver-kubernetes-1-29-0            1/1     Running   2 (78s ago)   32m
kube-system        kube-controller-manager-kubernetes-1-29-0   1/1     Running   2 (78s ago)   32m
kube-system        kube-proxy-ztvnv                            1/1     Running   2 (78s ago)   32m
kube-system        kube-scheduler-kubernetes-1-29-0            1/1     Running   2 (78s ago)   32m
tigera-operator    tigera-operator-79f59b7cb7-jw9sg            1/1     Running   2 (43s ago)   15m
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
root@kubernetes-1-29-0:~# helm version
version.BuildInfo{Version:"v3.14.0", GitCommit:"3fc9f4b2638e76f26739cd77c7017139be81d0ea", GitTreeState:"clean", GoVersion:"go1.21.5"}
root@kubernetes-1-29-0:~# kubectl version
Client Version: v1.29.0
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.29.0
root@kubernetes-1-29-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.1 1677a17964311325ed1c31e2c0a3589ce6d5c30d
root@kubernetes-1-29-0:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@kubernetes-1-29-0:~# uname -a
Linux kubernetes-1-29-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-29-0:~# cat /etc/os-release
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
```

## build

```shell
make all DIR=kubernetes/v1.29.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.29.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
