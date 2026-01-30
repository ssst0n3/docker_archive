# kubernetes v1.35.0 with calico, nerdctl v2.2.0

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.35.0-calico_nerdctl-v2.2.0 -> ssst0n3/docker_archive:kubernetes-v1.35.0-calico_nerdctl-v2.2.0_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.35.0-calico_nerdctl-v2.2.0_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.35.0-calico_nerdctl-v2.2.0 -> ssst0n3/docker_archive:ctr_kubernetes-v1.35.0-calico_nerdctl-v2.2.0_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.35.0-calico_nerdctl-v2.2.0_v0.1.0

## usage

```shell
$ cd kubernetes/v1.35.0-calico_nerdctl-v2.2.0
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### nerdctl

```shell
root@kubernetes-1-35-0:~# nerdctl run hello-world
Hello from Docker!
...
root@kubernetes-1-35-0:~# echo 'FROM hello-world' > Dockerfile
root@kubernetes-1-35-0:~# nerdctl build -t foo .
root@kubernetes-1-35-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED          PLATFORM       SIZE       BLOB SIZE
foo            latest    f35374a8a2f6    2 seconds ago    linux/amd64    16.38kB    3.426kB
hello-world    latest    05813aedc15f    6 minutes ago    linux/amd64    16.38kB    3.962kB
```

### environment details

```shell
$ ./ssh
root@kubernetes-1-35-0:~# nerdctl --version
nerdctl version 2.2.0
root@kubernetes-1-35-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.25.2 dcc0fe5e96ae78919b30057d0804c52f13a2eb7e
root@kubernetes-1-35-0:~# helm version
version.BuildInfo{Version:"v4.0.4", GitCommit:"8650e1dad9e6ae38b41f60b712af9218a0d8cc11", GitTreeState:"clean", GoVersion:"go1.25.5", KubeClientVersion:"v1.34"}
root@kubernetes-1-35-0:~# kubectl version
Client Version: v1.35.0
Kustomize Version: v5.7.1
Server Version: v1.35.0
root@kubernetes-1-35-0:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.2.0 1c4457e00facac03ce1d75f7b6777a7a851e5c41
root@kubernetes-1-35-0:~# runc --version
runc version 1.3.3
commit: v1.3.3-0-gd842d771
spec: 1.2.1
go: go1.23.12
libseccomp: 2.5.6
root@kubernetes-1-35-0:~# cat /etc/os-release
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
root@kubernetes-1-35-0:~# uname -a
Linux kubernetes-1-35-0 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.35.0-calico_nerdctl-v2.2.0
```
