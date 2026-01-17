# nerdctl v2.0.3 (containerd v2.0.3)

* dqd: 
    * ssst0n3/docker_archive:nerdctl-v2.0.3_containerd-v2.0.3 -> ssst0n3/docker_archive:nerdctl-v2.0.3_containerd-v2.0.3_v0.1.0
    * ssst0n3/docker_archive:nerdctl-v2.0.3_containerd-v2.0.3_v0.1.0
* ctr:
    * ssst0n3/docker_archive:ctr_nerdctl-v2.0.3_containerd-v2.0.3 -> ssst0n3/docker_archive:ctr_nerdctl-v2.0.3_containerd-v2.0.3_v0.1.0
    * ssst0n3/docker_archive:ctr_nerdctl-v2.0.3_containerd-v2.0.3_v0.1.0

## how-to

```shell
$ cd nerdctl/v2.0.3_containerd-v2.0.3
$ docker compose -f docker-compose.yml -f docker-compose.kvm.yml up -d
```

### usage

```shell
$ ./ssh
root@nerdctl-2-0-3-containerd-2-0-3:~# nerdctl run hello-world
...
Hello from Docker!
...
root@nerdctl-2-0-3-containerd-2-0-3:~# echo 'FROM hello-world' > Dockerfile
root@nerdctl-2-0-3-containerd-2-0-3:~# nerdctl build -t foo .
root@nerdctl-2-0-3-containerd-2-0-3:~# nerdctl images
REPOSITORY     TAG       IMAGE ID        CREATED           PLATFORM       SIZE       BLOB SIZE
foo            latest    f35374a8a2f6    20 seconds ago    linux/amd64    16.38kB    3.426kB
hello-world    latest    d4aaab6242e0    52 seconds ago    linux/amd64    16.38kB    3.962kB
```

### environment details

```shell
$ ./ssh
root@nerdctl-2-0-3-containerd-2-0-3:~# nerdctl --version
nerdctl version 2.0.3
root@nerdctl-2-0-3-containerd-2-0-3:~# buildkitd --version
buildkitd github.com/moby/buildkit v0.19.0 3637d1b15a13fc3cdd0c16fcf3be0845ae68f53d
root@nerdctl-2-0-3-containerd-2-0-3:~# containerd --version
containerd github.com/containerd/containerd/v2 v2.0.3 06b99ca80cdbfbc6cc8bd567021738c9af2b36ce
root@nerdctl-2-0-3-containerd-2-0-3:~# runc --version
runc version 1.2.5
commit: v1.2.5-0-g59923ef1
spec: 1.2.0
go: go1.22.12
libseccomp: 2.5.5
root@nerdctl-2-0-3-containerd-2-0-3:~# cat /etc/os-release 
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
root@nerdctl-2-0-3-containerd-2-0-3:~# uname -a
Linux nerdctl-2-0-3-containerd-2-0-3 6.8.0-90-generic #91-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 18 14:14:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

## build

```shell
make all DIR=nerdctl/v2.0.3_containerd-v2.0.3
```

for developers:

```dockerfile
FROM ssst0n3/docker_archive:ctr_nerdctl-v2.0.3_containerd-v2.0.3_v0.1.0
```

