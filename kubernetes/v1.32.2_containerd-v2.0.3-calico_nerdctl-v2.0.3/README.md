# kubernetes v1.32.2 with containerd v2.0.3, calico, nerdctl v2.0.3

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3 -> ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3 -> ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3_v0.1.0

## usage

```shell
$ cd kubernetes/v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### nerdctl

```shell
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# nerdctl run hello-world
...
Hello from Docker!
...
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# echo 'FROM hello-world' > Dockerfile
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# nerdctl build -t foo .
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE       BLOB SIZE
foo            latest    f35374a8a2f6    4 seconds ago     linux/amd64    16.38kB    3.426kB
hello-world    latest    d4aaab6242e0    30 seconds ago    linux/amd64    16.38kB    3.962kB
```

### environment details

```shell
$ ./ssh
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# nerdctl --version
nerdctl version 2.0.3
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.19.0 3637d1b15a13fc3cdd0c16fcf3be0845ae68f53d
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# helm version
kversion.BuildInfo{Version:"v3.16.4", GitCommit:"7877b45b63f95635153b29a42c0c2f4273ec45ca", GitTreeState:"clean", GoVersion:"go1.22.7"}
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# kubectl version
Client Version: v1.32.2
Kustomize Version: v5.5.0
Server Version: v1.32.2
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.3 06b99ca80cdbfbc6cc8bd567021738c9af2b36ce
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# cat /etc/os-release 
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
root@kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3:~# uname -a
Linux kubernetes-1-32-2-containerd-2-0-3-calico-nerdctl-2-0-3 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.32.2_containerd-v2.0.3-calico_nerdctl-v2.0.3
```
