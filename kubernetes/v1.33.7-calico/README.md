# kubernetes v1.33.7, with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.7-calico -> ssst0n3/docker_archive:kubernetes-v1.33.7-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.7-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.7-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.7-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.7-calico_v0.1.0

## usage

### startup

```shell
$ cd kubernetes/v1.33.7-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### built-in pods

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS        AGE
calico-apiserver   calico-apiserver-5965dbd4f7-s7scf           1/1     Running   1 (9m20s ago)   40m
calico-apiserver   calico-apiserver-5965dbd4f7-xz728           1/1     Running   1 (9m20s ago)   40m
calico-system      calico-kube-controllers-849f9b6c88-n9smn    1/1     Running   1 (9m20s ago)   40m
calico-system      calico-node-kqvh7                           1/1     Running   1 (9m20s ago)   40m
calico-system      calico-typha-5888bc8bd8-n5prf               1/1     Running   1 (9m20s ago)   40m
calico-system      csi-node-driver-z5n76                       2/2     Running   2 (9m20s ago)   40m
calico-system      goldmane-b49dd46d7-dgpxs                    1/1     Running   1 (9m20s ago)   40m
calico-system      whisker-658bcbcf4d-gtm7p                    2/2     Running   2 (9m20s ago)   38m
kube-system        coredns-674b8bbfcf-fs9n4                    1/1     Running   1 (9m20s ago)   88m
kube-system        coredns-674b8bbfcf-kt4xj                    1/1     Running   1 (9m20s ago)   88m
kube-system        etcd-kubernetes-1-33-7                      1/1     Running   2 (9m20s ago)   88m
kube-system        kube-apiserver-kubernetes-1-33-7            1/1     Running   2 (9m20s ago)   88m
kube-system        kube-controller-manager-kubernetes-1-33-7   1/1     Running   2 (9m20s ago)   88m
kube-system        kube-proxy-jkn6s                            1/1     Running   2 (9m20s ago)   88m
kube-system        kube-scheduler-kubernetes-1-33-7            1/1     Running   2 (9m20s ago)   88m
tigera-operator    tigera-operator-6d69b9b454-pj7r8            1/1     Running   1 (9m20s ago)   40m
```

### deploy a pod

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          39s
```

### versions

```shell
$ ./ssh
root@kubernetes-1-33-7:~# helm version
version.BuildInfo{Version:"v3.18.4", GitCommit:"d80839cf37d860c8aa9a0503fe463278f26cd5e2", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-7:~# kubectl version
Client Version: v1.33.7
Kustomize Version: v5.6.0
Server Version: v1.33.7
root@kubernetes-1-33-7:~# nerdctl --version
nerdctl version 2.1.6
root@kubernetes-1-33-7:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.24.0 b772c318368090fb2ffc9c0fed92e0a35bf82389
root@kubernetes-1-33-7:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.5 fcd43222d6b07379a4be9786bda52438f0dd16a1
root@kubernetes-1-33-7:~# runc --version
runc version 1.3.3
commit: v1.3.3-0-gd842d771
spec: 1.2.1
go: go1.23.12
libseccomp: 2.5.6
root@kubernetes-1-33-7:~# cat /etc/os-release
PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
root@kubernetes-1-33-7:~# uname -a
Linux kubernetes-1-33-7 6.8.0-94-generic #96-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan  9 20:36:55 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.33.7-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.33.7-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
