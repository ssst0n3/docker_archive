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
calico-apiserver   calico-apiserver-7f6589f78d-27scs           1/1     Running   1 (4m19s ago)   22m
calico-apiserver   calico-apiserver-7f6589f78d-h8t6h           1/1     Running   1 (4m19s ago)   22m
calico-system      calico-kube-controllers-bf9867dc7-glt94     1/1     Running   1 (4m19s ago)   25m
calico-system      calico-node-8mkc9                           1/1     Running   1 (4m19s ago)   25m
calico-system      calico-typha-f7f689689-jmm5j                1/1     Running   1 (4m19s ago)   25m
calico-system      csi-node-driver-2xrls                       2/2     Running   2 (4m19s ago)   25m
kube-system        coredns-5d78c9869d-q4mx9                    1/1     Running   1 (4m19s ago)   168m
kube-system        coredns-5d78c9869d-rtdhk                    1/1     Running   1 (4m19s ago)   168m
kube-system        etcd-kubernetes-1-27-0                      1/1     Running   2 (4m19s ago)   168m
kube-system        kube-apiserver-kubernetes-1-27-0            1/1     Running   2 (4m19s ago)   168m
kube-system        kube-controller-manager-kubernetes-1-27-0   1/1     Running   2 (4m19s ago)   168m
kube-system        kube-proxy-s62g9                            1/1     Running   2 (4m19s ago)   168m
kube-system        kube-scheduler-kubernetes-1-27-0            1/1     Running   2 (4m19s ago)   168m
tigera-operator    tigera-operator-7b4b4fcf5d-n9mkx            1/1     Running   2 (3m43s ago)   25m
```

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          3m41s
```

```shell
$ ./ssh
root@kubernetes-1-27-0:~# helm version
version.BuildInfo{Version:"v3.12.0", GitCommit:"c9f554d75773799f72ceef38c51210f1842a1dea", GitTreeState:"clean", GoVersion:"go1.20.3"}
root@kubernetes-1-27-0:~# kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.0", GitCommit:"1b4df30b3cdfeaba6024e81e559a6cd09a089d65", GitTreeState:"clean", BuildDate:"2023-04-11T17:10:18Z", GoVersion:"go1.20.3", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v5.0.1
Server Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.0", GitCommit:"1b4df30b3cdfeaba6024e81e559a6cd09a089d65", GitTreeState:"clean", BuildDate:"2023-04-11T17:04:24Z", GoVersion:"go1.20.3", Compiler:"gc", Platform:"linux/amd64"}
root@kubernetes-1-27-0:~# containerd --version
containerd github.com/containerd/containerd v1.6.19 1e1ea6e986c6c86565bc33d52e34b81b3e2bc71f
root@kubernetes-1-27-0:~# runc --version
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.17.10
libseccomp: 2.5.4
root@kubernetes-1-27-0:~# cat /etc/os-release
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
root@kubernetes-1-27-0:~# uname -a
Linux kubernetes-1-27-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.27.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.27.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
