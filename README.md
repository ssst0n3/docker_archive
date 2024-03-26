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
$ docker run -ti --name docker-1.12.3 ssst0n3/docker_archive:ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1_v0.1.0
ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

#### 1.2 tty with detach

```
$ docker run -tid --name docker-1.12.3 ssst0n3/docker_archive:ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1_v0.1.0
$ docker attach --detach-keys ctrl-x docker-1.12.3
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
$ git checkout branch_ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1
$ docker compose up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1_v0.1.0
    ports:
        - "11230:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p docker-17-03-0 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1
$ docker compose -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1_v0.1.0
    ports:
        - "11230:22"
    command: /start_vm.sh -m 2560M -cpu host -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p docker-1-12-3 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

#### Step3: Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 11230 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

## version
* `ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1`
* `ubuntu-16.04_docker.io-1.12.3_containerd-0.2.3_runc-1.0.0-rc1_v0.1.0` 

```
root@ubuntu:~# docker version
Client:
 Version:      1.12.3
 API version:  1.24
 Go version:   go1.6.2
 Git commit:   6b644ec
 Built:        Mon, 19 Dec 2016 09:20:48 +1300
 OS/Arch:      linux/amd64

Server:
 Version:      1.12.3
 API version:  1.24
 Go version:   go1.6.2
 Git commit:   6b644ec
 Built:        Mon, 19 Dec 2016 09:20:48 +1300
 OS/Arch:      linux/amd64
root@ubuntu:~# containerd --version
containerd version 0.2.3
root@ubuntu:~# runc --version
runc version spec: 1.0.0-rc1
```