# kubernetes v1.30.0 with calico

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.30.0-calico -> ssst0n3/docker_archive:kubernetes-v1.30.0-calico_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.30.0-calico_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.30.0-calico -> ssst0n3/docker_archive:ctr_kubernetes-v1.30.0-calico_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.30.0-calico_v0.1.0

## usage

```shell
$ cd kubernetes/v1.30.0-calico
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

```shell
$ kubectl --kubeconfig=kubeconfig get pods -A
NAMESPACE          NAME                                        READY   STATUS    RESTARTS      AGE
calico-apiserver   calico-apiserver-5f7596c87c-28872           1/1     Running   1 (87s ago)   50m
calico-apiserver   calico-apiserver-5f7596c87c-srvw5           1/1     Running   1 (87s ago)   50m
calico-system      calico-kube-controllers-678f76bcf9-kw8gf    1/1     Running   1 (87s ago)   50m
calico-system      calico-node-gnv7t                           1/1     Running   1 (87s ago)   50m
calico-system      calico-typha-5c44dd5fb5-vrqgk               1/1     Running   1 (87s ago)   50m
calico-system      csi-node-driver-96kr4                       2/2     Running   2 (87s ago)   50m
kube-system        coredns-7db6d8ff4d-jmmm6                    1/1     Running   1 (87s ago)   143m
kube-system        coredns-7db6d8ff4d-mlptt                    1/1     Running   1 (87s ago)   143m
kube-system        etcd-kubernetes-1-30-0                      1/1     Running   2 (87s ago)   143m
kube-system        kube-apiserver-kubernetes-1-30-0            1/1     Running   2 (87s ago)   143m
kube-system        kube-controller-manager-kubernetes-1-30-0   1/1     Running   2 (87s ago)   143m
kube-system        kube-proxy-j9rmn                            1/1     Running   2 (87s ago)   143m
kube-system        kube-scheduler-kubernetes-1-30-0            1/1     Running   2 (87s ago)   143m
tigera-operator    tigera-operator-696858f46-ttwqc             1/1     Running   1 (87s ago)   50m
```

```shell
$ kubectl --kubeconfig=kubeconfig run --image=docker.io/library/nginx:latest nginx
pod/nginx created
$ kubectl --kubeconfig=kubeconfig get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          46s
```

```shell
$ ./ssh
root@kubernetes-1-30-0:~# helm version
version.BuildInfo{Version:"v3.15.0-rc.2", GitCommit:"c4e37b39dbb341cb3f716220df9f9d306d123a58", GitTreeState:"clean", GoVersion:"go1.22.3"}
root@kubernetes-1-30-0:~# kubectl version
Client Version: v1.30.0
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.30.0
root@kubernetes-1-30-0:~# containerd --version
containerd github.com/containerd/containerd v1.7.15 926c9586fe4a6236699318391cd44976a98e31f1
root@kubernetes-1-30-0:~# runc --version
runc version 1.1.12
commit: v1.1.12-0-g51d5e946
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.4
root@kubernetes-1-30-0:~# uname -a
Linux kubernetes-1-30-0 5.15.0-161-generic #171-Ubuntu SMP Sat Oct 11 08:17:01 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@kubernetes-1-30-0:~# cat /etc/os-release
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
make all DIR=kubernetes/v1.30.0-calico
```


### for developers

```dockerfile
# syntax=docker/dockerfile:1-labs
FROM ssst0n3/docker_archive:ctr_kubernetes-v1.30.0-calico_v0.1.0
...
RUN --security=insecure ["/sbin/init", "--log-target=kmsg"]
```

* use `dmesg -w` to see build logs.
* use systemd service to execute commands
* ssh root/root 10.0.2.16 to debug
