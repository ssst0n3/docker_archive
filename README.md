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
$ docker run -ti --name docker-ce-18.09.9 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6_v0.1.0
...
Ubuntu 20.04.1 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

#### 1.2 tty with detach

```
$ docker run -tid --name docker-ce-18.09.9 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6_v0.1.0
$ docker attach --detach-keys ctrl-x docker-ce-18.09.9
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
$ git checkout branch_ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6
$ docker compose -p docker-18-09-9 -f docker-compose.yml up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6_v0.1.0
    ports:
        - "18099:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p docker-18-09-9 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6
$ docker compose -p docker-18-09-9 -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6_v0.1.0
    ports:
        - "18099:22"
    command: /start_vm.sh -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p docker-18-09-9 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

#### Step3: Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 18099 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

## version
* `ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6`
* `ubuntu-20.04_docker-ce-18.09.9_containerd.io-1.2.2-3_runc-1.0.0-rc6_v0.1.0`

```
root@ubuntu:~# docker version
Client:
 Version:           18.09.9
 API version:       1.39
 Go version:        go1.11.13
 Git commit:        039a7df9ba
 Built:             Wed Sep  4 17:24:10 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.9
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.11.13
  Git commit:       039a7df
  Built:            Wed Sep  4 16:19:38 2019
  OS/Arch:          linux/amd64
  Experimental:     false
root@ubuntu:~# containerd --version
containerd github.com/containerd/containerd 1.2.2 9754871865f7fe2f4e74d43e2fc7ccd237edcbce
root@ubuntu:~# runc --version
runc version 1.0.0-rc6+dev
commit: 09c8266bf2fcf9519a651b04ae54c967b9ab86ec
spec: 1.0.1-dev
```