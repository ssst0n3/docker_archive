---

spec-version: v0.2.4
hierarchy: release
image-version: v0.1.2

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
$ docker run -ti --name docker-ce-19.03.11 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1
...
Ubuntu 20.04.1 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

#### 1.2 tty with detach

```
$ docker run -tid --name docker-ce-19.03.11 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1
$ docker attach --detach-keys ctrl-x docker-ce-19.03.11
...
Ubuntu 20.04.1 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

### 2. ssh

#### Step1: Get the compose file to start the environment

##### a) ssh without kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1
$ docker compose -p docker_19-03-11 -f docker-compose.yml up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1_v0.1.1
    ports:
        - "19311:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p docker_19-03-11 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1
$ docker compose -p docker_19-03-11 -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1_v0.1.1
    ports:
      - "19311:22"
    command: /start_vm.sh -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p docker_19-03-11 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

#### Step3: Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 19037 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

## version

* `ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1`
* `ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1_v0.1.2`
* `ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1_v0.1.1`
* `ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1_v0.1.0`


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