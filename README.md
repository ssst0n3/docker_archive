---

spec-version: v0.3.0
hierarchy: release
image-version: v0.1.0

---

# docker archive

Provide most versions of docker. 

You can get specify version of docker such as docker 19.03 by pull an container image.

There will be an qemu in the docker image, and a docker 19.03 in qemu.

Yep, this form is like Russian nesting dolls, but it's convenient for container security research.

## run 

There are different ways to start up the environment.

### 1. tty 

#### 1.1 tty

```
$ docker run -ti --name docker-ce-24.0.7 ssst0n3/docker_archive:ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11_v0.1.0
...
Ubuntu 22.04 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

#### 1.2 tty with detach

```
$ docker run -tid --name docker-ce-24.0.7 ssst0n3/docker_archive:ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11_v0.1.0
$ docker attach --detach-keys ctrl-x docker-ce-24.0.7
...
Ubuntu 22.04 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

use ctrl-x to detach

### 2. ssh

#### Step1: Get the compose file to start the environment

##### a) ssh without kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11
$ docker compose -f docker-compose.yml up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11
    ports:
        - "24007:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p docker-24-0-7 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11
$ docker compose -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11_v0.1.0
    ports:
        - "24007:22"
    command: /start_vm.sh -m 2560M -cpu host -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p docker-24-0-7 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.


#### Step3: Enter the environemnt
Then ssh into the vm with docker installed:

```
$ ssh -p 24007 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

## version
* `ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11`
* `ubuntu-22.04_docker-ce-24.0.7_containerd.io-1.6.27_runc-1.1.11_v0.1.0`

```
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           24.0.7
 API version:       1.43
 Go version:        go1.20.10
 Git commit:        afdd53b
 Built:             Thu Oct 26 09:07:41 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          24.0.7
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.10
  Git commit:       311b9ff
  Built:            Thu Oct 26 09:07:41 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.27
  GitCommit:        a1496014c916f9e62104b33d1bb5bd03b0858e59
 runc:
  Version:          1.1.11
  GitCommit:        v1.1.11-0-g4bccb38
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

```
root@ubuntu:~# containerd --version
containerd containerd.io 1.6.27 a1496014c916f9e62104b33d1bb5bd03b0858e59
```

```
root@ubuntu:~# runc --version
runc version 1.1.11
commit: v1.1.11-0-g4bccb38
spec: 1.0.2-dev
go: go1.20.13
libseccomp: 2.5.3
```