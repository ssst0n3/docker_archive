# kubernetes v1.34.0 with calico, nerdctl v2.1.4

* dqd:
  * ssst0n3/docker_archive:kubernetes-v1.34.0-calico_nerdctl-v2.1.4 -> ssst0n3/docker_archive:kubernetes-v1.34.0-calico_nerdctl-v2.1.4_v0.1.0
  * ssst0n3/docker_archive:kubernetes-v1.34.0-calico_nerdctl-v2.1.4_v0.1.0
* ctr:
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-calico_nerdctl-v2.1.4 -> ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-calico_nerdctl-v2.1.4_v0.1.0
  * ssst0n3/docker_archive:ctr_kubernetes-v1.34.0-calico_nerdctl-v2.1.4_v0.1.0

## usage

```shell
$ cd kubernetes/v1.34.0-calico_nerdctl-v2.1.4
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### nerdctl

```shell
root@kubernetes-1-34-0:~# nerdctl run hello-world
Hello from Docker!
...
root@kubernetes-1-34-0:~# echo 'FROM hello-world' > Dockerfile
root@kubernetes-1-34-0:~# nerdctl build -t foo .
root@kubernetes-1-34-0:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED                   PLATFORM       SIZE       BLOB SIZE
foo            latest    f35374a8a2f6    Less than a second ago    linux/amd64    16.38kB    3.426kB
hello-world    latest    05813aedc15f    About a minute ago        linux/amd64    16.38kB    3.962kB
```

### environment details

```shell
$ ./ssh
root@kubernetes-1-34-0:~# nerdctl --version
nerdctl version 2.1.4
root@kubernetes-1-34-0:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.24.0 b772c318368090fb2ffc9c0fed92e0a35bf82389
root@kubernetes-1-34-0:~# helm version
version.BuildInfo{Version:"v3.19.0", GitCommit:"3d8990f0836691f0229297773f3524598f46bda6", GitTreeState:"clean", GoVersion:"go1.24.7"}
root@kubernetes-1-34-0:~# kubectl version
Client Version: v1.34.0
Kustomize Version: v5.7.1
Server Version: v1.34.0
root@kubernetes-1-34-0:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.1.4 75cb2b7193e4e490e9fbdc236c0e811ccaba3376
root@kubernetes-1-34-0:~# runc --version
runc version 1.3.0
commit: v1.3.0-0-g4ca628d1
spec: 1.2.1
go: go1.23.8
libseccomp: 2.5.6
root@kubernetes-1-34-0:~# cat /etc/os-release 
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
root@kubernetes-1-34-0:~# uname -a
Linux kubernetes-1-34-0 6.8.0-94-generic #96-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan  9 20:36:55 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=kubernetes/v1.34.0-calico_nerdctl-v2.1.4
```
