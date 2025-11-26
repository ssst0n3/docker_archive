# kubernetes v1.27.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.27.0-calico -> ssst0n3/docker_archive:kubernetes-v1.27.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.27.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.27.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.27.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.27.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.27.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-85bf5f7489-8cfnx           1/1     Running   1 (8m27s ago)   9m19s
calico-apiserver   calico-apiserver-85bf5f7489-9qr7b           1/1     Running   1 (8m27s ago)   9m19s
calico-system      calico-kube-controllers-bf9867dc7-xfzvm     1/1     Running   1 (8m27s ago)   11m
calico-system      calico-node-bcbxh                           1/1     Running   1 (8m27s ago)   11m
calico-system      calico-typha-54fff9bd67-kqfs8               1/1     Running   2 (24s ago)     11m
calico-system      csi-node-driver-kv4tz                       2/2     Running   2 (8m27s ago)   11m
kube-system        coredns-5d78c9869d-b4pv8                    1/1     Running   1 (70s ago)     2d17h
kube-system        coredns-5d78c9869d-zb7mz                    1/1     Running   1 (71s ago)     2d17h
kube-system        etcd-kubernetes-1-27-0                      1/1     Running   2 (8m27s ago)   2d17h
kube-system        kube-apiserver-kubernetes-1-27-0            1/1     Running   2 (71s ago)     2d17h
kube-system        kube-controller-manager-kubernetes-1-27-0   1/1     Running   2 (8m27s ago)   2d17h
kube-system        kube-proxy-r9bt7                            1/1     Running   2 (8m27s ago)   2d17h
kube-system        kube-scheduler-kubernetes-1-27-0            1/1     Running   2 (71s ago)     2d17h
tigera-operator    tigera-operator-7b4b4fcf5d-bxpgk            1/1     Running   2 (23s ago)     12m
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
root@kubernetes-1-28-0:~# helm version
version.BuildInfo{Version:"v3.13.0", GitCommit:"825e86f6a7a38cef1112bfa606e4127a706749b1", GitTreeState:"clean", GoVersion:"go1.20.8"}
root@kubernetes-1-28-0:~# kubectl version
Client Version: v1.28.0
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.28.0
root@kubernetes-1-28-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.21 3dce8eb055cbb6872793272b4f20ed16117344f8
root@kubernetes-1-28-0:~# runc --version
runc version 1.1.7
commit: v1.1.7-0-g860f061b
spec: 1.0.2-dev
go: go1.20.3
libseccomp: 2.5.4
root@kubernetes-1-28-0:~# uname -a
Linux kubernetes-1-28-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-28-0:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.28.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.28.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
