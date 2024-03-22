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
$ docker run -ti --name docker-ce-18.09.0 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8_v0.1.0
...
Ubuntu 20.04.1 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# docker version
```

#### 1.2 tty with detach

```
$ docker run -tid --name docker-ce-18.09.0 ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8_v0.1.0
$ docker attach --detach-keys ctrl-x docker-ce-18.09.0
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
$ git checkout branch_ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8
$ docker compose -p docker-18-09-0 -f docker-compose.yml up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8_v0.1.0
    ports:
        - "18090:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p docker-18-09-0 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8
$ docker compose -p docker-18-09-0 -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8_v0.1.0
    ports:
        - "18090:22"
    command: /start_vm.sh -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p docker-18-09-0 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

#### Step3: Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 18090 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# docker version
```

## version
* `ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8`
* `ubuntu-20.04_docker-ce-18.09.0_containerd.io-1.2.6.3_runc-1.0.0-rc8_v0.1.0`

```
root@ubuntu:~# docker version
Client: Docker Engine - Community
 Version:           19.03.5
 API version:       1.40
 Go version:        go1.12.12
 Git commit:        633a0ea838
 Built:             Wed Nov 13 07:29:52 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.5
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.12
  Git commit:       633a0ea838
  Built:            Wed Nov 13 07:28:22 2019
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