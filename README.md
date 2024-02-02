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
$ docker run -ti --name docker-ce-17.03.0 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-17.03.0_v0.1.0
...
Ubuntu 20.04.1 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

#### 1.2 tty with detach

```
$ docker run -tid --name docker-ce-17.03.0 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-17.03.0_v0.1.0
$ docker attach --detach-keys ctrl-x docker-ce-17.03.0
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
$ git checkout branch_ubuntu-20.04_docker-ce-17.03.0
$ docker compose up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-17.03.0_v0.1.0
    ports:
        - "17030:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p docker-17-03-0 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-17.03.0
$ docker compose -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-17.03.0_v0.1.0
    ports:
        - "17030:22"
    command: /start_vm.sh -m 2560M -cpu host -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p docker-19-03-7 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

#### Step3: Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 17030 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

## version
* `ubuntu-20.04_docker-ce-17.03.0`
* `ubuntu-20.04_docker-ce-17.03.0_v0.1.0`

```
root@ubuntu:~# docker version
Client:
 Version:      17.03.0-ce
 API version:  1.26
 Go version:   go1.7.5
 Git commit:   3a232c8
 Built:        Tue Feb 28 08:01:32 2017
 OS/Arch:      linux/amd64

Server:
 Version:      17.03.0-ce
 API version:  1.26 (minimum version 1.12)
 Go version:   go1.7.5
 Git commit:   3a232c8
 Built:        Tue Feb 28 08:01:32 2017
 OS/Arch:      linux/amd64
 Experimental: false
```

```
root@ubuntu:~# docker-containerd --version
containerd version 0.2.3 commit: 977c511eda0925a723debdc94d09459af49d082a
```

```
root@ubuntu:~# docker-runc --version
runc version 1.0.0-rc2
commit: a01dafd48bc1c7cc12bdb01206f9fea7dd6feb70
spec: 1.0.0-rc2-dev
```