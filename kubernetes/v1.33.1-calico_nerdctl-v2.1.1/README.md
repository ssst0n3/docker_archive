# kubernetes v1.33.1 with calico, nerdctl v2.1.1

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.33.1-calico_nerdctl-v2.1.1 -> ssst0n3/docker_archive:kubernetes-v1.33.1-calico_nerdctl-v2.1.1_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.33.1-calico_nerdctl-v2.1.1_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico_nerdctl-v2.1.1 -> ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico_nerdctl-v2.1.1_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.33.1-calico_nerdctl-v2.1.1_v0.1.0

## usage

```shell
$ cd kubernetes/v1.33.1-calico_nerdctl-v2.1.1
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### nerdctl

```shell
root@kubernetes-1-33-1:~# nerdctl run hello-world
Hello from Docker!
...
root@kubernetes-1-33-1:~# echo 'FROM hello-world' > Dockerfile
root@kubernetes-1-33-1:~# nerdctl build -t foo .
root@kubernetes-1-33-1:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED                   PLATFORM       SIZE       BLOB SIZE
foo            latest    f35374a8a2f6    Less than a second ago    linux/amd64    16.38kB    3.426kB
hello-world    latest    05813aedc15f    9 seconds ago             linux/amd64    16.38kB    3.962kB
```

### environment details

```shell
$ ./ssh
root@kubernetes-1-33-1:~# nerdctl --version
nerdctl version 2.1.1
root@kubernetes-1-33-1:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.21.1 66735c67040bc80e6ed104f451683e094030a4e1
root@kubernetes-1-33-1:~# helm version
version.BuildInfo{Version:"v3.18.3", GitCommit:"6838ebcf265a3842d1433956e8a622e3290cf324", GitTreeState:"clean", GoVersion:"go1.24.4"}
root@kubernetes-1-33-1:~# kubectl version
Client Version: v1.33.1
Kustomize Version: v5.6.0
Server Version: v1.33.1
root@kubernetes-1-33-1:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.0 061792f0ecf3684fb30a3a0eb006799b8c6638a7
root@kubernetes-1-33-1:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@kubernetes-1-33-1:~# cat /etc/os-release
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
root@kubernetes-1-33-1:~# uname -a
Linux kubernetes-1-33-1 6.8.0-94-generic #96-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan  9 20:36:55 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.33.1-calico_nerdctl-v2.1.1
```
