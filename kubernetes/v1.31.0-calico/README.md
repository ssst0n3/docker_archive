# kubernetes v1.31.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.31.0-calico -> ssst0n3/docker_archive:kubernetes-v1.31.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.31.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.31.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.31.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.31.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.31.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-6fc546b4cd-msr5g           1/1     Running   1 (2m28s ago)   17m
calico-apiserver   calico-apiserver-6fc546b4cd-rbxr4           1/1     Running   1 (2m28s ago)   17m
calico-system      calico-kube-controllers-bf7cf4d65-jpn48     1/1     Running   1 (2m28s ago)   17m
calico-system      calico-node-kqdbc                           1/1     Running   1 (2m28s ago)   17m
calico-system      calico-typha-846c5578bc-5hqss               1/1     Running   1 (2m28s ago)   17m
calico-system      csi-node-driver-9vppz                       2/2     Running   2 (2m28s ago)   17m
kube-system        coredns-6f6b679f8f-9txt4                    1/1     Running   1 (2m28s ago)   78m
kube-system        coredns-6f6b679f8f-qf4sg                    1/1     Running   1 (2m28s ago)   78m
kube-system        etcd-kubernetes-1-31-0                      1/1     Running   2 (14m ago)     78m
kube-system        kube-apiserver-kubernetes-1-31-0            1/1     Running   2 (2m28s ago)   78m
kube-system        kube-controller-manager-kubernetes-1-31-0   1/1     Running   2 (2m28s ago)   78m
kube-system        kube-proxy-vd7w9                            1/1     Running   2 (2m28s ago)   78m
kube-system        kube-scheduler-kubernetes-1-31-0            1/1     Running   2 (2m28s ago)   78m
tigera-operator    tigera-operator-cb7dd5ff7-ts7db             1/1     Running   1 (2m28s ago)   17m
```

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          2m40s
```

```shell
$ ./ssh
root@kubernetes-1-31-0:~# helm version
version.BuildInfo{Version:"v3.16.0", GitCommit:"0d439e1a09683f21a0ab9401eb661401f185b00b", GitTreeState:"clean", GoVersion:"go1.22.6"}
root@kubernetes-1-31-0:~# kubectl version
Client Version: v1.31.0
Kustomize Version: v5.4.2
Server Version: v1.31.0
root@kubernetes-1-31-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.18 ae71819c4f5e67bb4d5ae76a6b735f29cc25774e
root@kubernetes-1-31-0:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
root@kubernetes-1-31-0:~# cat /etc/os-release
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
root@kubernetes-1-31-0:~# uname -a
Linux kubernetes-1-31-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.31.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.31.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
