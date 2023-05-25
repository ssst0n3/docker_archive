# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## tag template
{operating system version}_{docker and it's components version}

## run 

There are different ways to start up the environment.

### 1. Get the compose file to start the environment

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_kata-1.10.4-debug
$ docker compose -p kata_1-10-4-debug -f docker-compose.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_kata-1.10.4-debug
    ports:
      - "1104:22"
      - "2345:2345"
    devices:
      - "/dev/kvm:/dev/kvm"
EOF
$ docker compose -p kata_1-10-4-debug up -d
```

### 2. Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

### 3. Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 1104 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

### 4. debug

```
root@ubuntu:~# docker run -ti --runtime kata-runtime-debug ubuntu
```

Debug in the IDE.

## version
`ubuntu-20.04_docker-ce-19.03.7_containerd.io-1.2.6.3_kata-1.10.4-debug`

```
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           19.03.7
 API version:       1.40
 Go version:        go1.12.17
 Git commit:        7141c199a2
 Built:             Wed Mar  4 01:22:36 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.7
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.17
  Git commit:       7141c199a2
  Built:            Wed Mar  4 01:21:08 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.6
  GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
 runc:
  Version:          1.0.0-rc8
  GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

```
root@ubuntu:~# containerd --version
containerd containerd.io 1.2.6 894b81a4b802e4eb2a91d1ce216b8817763c29fb
```

```
root@ubuntu:~# runc -version
runc version 1.0.0-rc8
commit: 425e105d5a03fabd737a126ad93d62a9eeede87f
spec: 1.0.1-dev
```

```
root@ubuntu:~# /opt/kata/bin/kata-runtime --version
kata-runtime  : 1.10.4
   commit   : dc550720a31582ced60d26cd7c64d746b1449864
   OCI specs: 1.0.1-dev
```

```
root@ubuntu:~# /root/go/bin/dlv version
Delve Debugger
Version: 1.20.2
Build: $Id: e0c278ad8e0126a312b553b8e171e81bcbd37f60 $
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