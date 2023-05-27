---

spec-version: v0.2.3
hierarchy: release
image-version: v0.1.0

---

# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## run

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.0
$ docker compose -f docker-compose.yml up -d
# // wait for vm start, or use docker logs -f <CONTAINERID> to watch the starting progress.
$ ssh -p 2222 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker run --rm -ti --runtime kata-runtime ubuntu
root@17d02623cea7:/#
```

## version
`ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_kata-1.11.0`

```
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           19.03.11
 API version:       1.40
 Go version:        go1.13.10
 Git commit:        42e35e61f3
 Built:             Mon Jun  1 09:12:34 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.11
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.10
  Git commit:       42e35e61f3
  Built:            Mon Jun  1 09:11:07 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.9
  GitCommit:        e25210fe30a0a703442421b0f60afac609f950a3
 runc:
  Version:          1.0.1
  GitCommit:        v1.0.1-0-g4144b63
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

```
root@ubuntu:~# containerd --version
containerd containerd.io 1.4.9 e25210fe30a0a703442421b0f60afac609f950a3
```

```
root@ubuntu:~# runc --version
runc version 1.0.1
commit: v1.0.1-0-g4144b63
spec: 1.0.2-dev
go: go1.15.14
libseccomp: 2.4.3
```

```
root@ubuntu:~# /opt/kata/bin/kata-runtime --version
kata-runtime  : 1.11.0
   commit   : 23e554b316aa994c6f48c9b1bd84060629fd6361
   OCI specs: 1.0.1-dev
```

## troubleshouting

### 1. cannot run kata under vmware

```
time="2023-05-04T09:03:05Z" level=error msg="CPU property not found" arch=amd64 description=SSE4.1 na
me=sse4_1 pid=2251 source=runtime type=flag
time="2023-05-04T09:03:05Z" level=error msg="ERROR: System is not capable of running Kata Containers"
 arch=amd64 name=kata-runtime pid=2251 source=runtime
ERROR: System is not capable of running Kata Containers
```

* https://blog.csdn.net/kunyus/article/details/106986621
* https://discuss.linuxcontainers.org/t/lxd-4-0-cannot-use-vm-errors/7312

### 2. cannot set up guest memory 'dimm1'

```
root@ubuntu:~# docker run --runtime kata-runtime ubuntu
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
dbf6a9befcde: Pull complete
Digest: sha256:dfd64a3b4296d8c9b62aa3309984f8620b98d87e47492599ee20739e8eb54fbf
Status: Downloaded newer image for ubuntu:latest
docker: Error response from daemon: OCI runtime create failed: failed to launch qemu: exit status 1, error messages from qemu log: qemu-system-x86_64: -object memory-backend-ram,id=dimm1,size=2048M: cannot set up guest memory 'dimm1': Cannot allocate memory: unknown.
ERRO[0015] error waiting for container: context canceled
```

Increase the memory value in the docker-compose.yml:

`command: /start_vm.sh -m 4096M -cpu host -enable-kvm`