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
$ docker run -ti --name docker-20-10-0-beta1-containerd-1-4-1 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92_v0.1.0
...
Ubuntu 20.04.1 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

#### 1.2 tty with detach

```
$ docker run -tid --name docker-20-10-0-beta1-containerd-1-4-1 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92_v0.1.0
$ docker attach --detach-keys ctrl-x docker-20-10-0-beta1-containerd-1-4-1
...
Ubuntu 20.04.1 LTS ubuntu ttyS0

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
$ git checkout branch_ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92
$ docker compose -f docker-compose.yml up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92_v0.1.0
    ports:
        - "20102:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p docker-20-10-0-beta1-containerd-1-4-1 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92
$ docker compose -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92_v0.1.0
    ports:
        - "20102:22"
    command: /start_vm.sh -m 2560M -cpu host -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p docker-20-10-0-beta1-containerd-1-4-1 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.


#### Step3: Enter the environemnt
Then ssh into the vm with docker installed:

```
$ ssh -p 20102 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

## version
* `ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92`
* `ubuntu-20.04_docker-ce-20.10.0-beta1_containerd.io-1.4.1_runc-1.0.0-rc92_v0.1.0`

```
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           20.10.0-beta1
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        ac365d7
 Built:             Tue Oct 13 18:15:22 2020
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.0-beta1
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       9c15e82
  Built:            Tue Oct 13 18:13:38 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.1
  GitCommit:        c623d1b36f09f8ef6536a057bd658b3aa8632828
 runc:
  Version:          1.0.0-rc92
  GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

```
root@ubuntu:~# containerd --version
containerd containerd.io 1.4.1 c623d1b36f09f8ef6536a057bd658b3aa8632828
```

```
root@ubuntu:~# runc --version
runc version 1.0.0-rc92
commit: ff819c7e9184c13b7c2607fe6c30ae19403a7aff
spec: 1.0.2-dev
```