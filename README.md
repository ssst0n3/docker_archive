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
$ docker run -ti --name podman-4-4-3 ssst0n3/docker_archive:ubuntu-22.04_podman-4.4.3_runc-1.1.4_v0.1.0
...
Ubuntu 22.04 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# podman --version
```

#### 1.2 tty with detach

```
$ docker run -tid --name podman-4-4-3 ssst0n3/docker_archive:ubuntu-22.04_podman-4.4.3_runc-1.1.4_v0.1.0
$ docker attach --detach-keys ctrl-x podman-4-4-3
...
Ubuntu 22.04 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# podman --version
```

### 2. ssh

#### Step1: Get the compose file to start the environment

##### a) ssh without kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-22.04_podman-4.4.3_runc-1.1.4
$ docker compose -f docker-compose.yml up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-22.04_podman-4.4.3_runc-1.1.4_v0.1.0
    ports:
        - "4430:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p podman-4-4-3 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-22.04_podman-4.4.3_runc-1.1.4
$ docker compose -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-22.04_runc-1.1.4_v0.1.0
    ports:
      - "1140:22"
    command: /start_vm.sh -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p podman-4-4-3 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

#### Step3: Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 4430 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# runc --version
```

## version

* `ubuntu-22.04_podman-4.4.3_runc-1.1.4`
* `ubuntu-22.04_podman-4.4.3_runc-1.1.4_v0.1.0`

```
root@ubuntu:~# podman version
Client:       Podman Engine
Version:      4.4.3
API Version:  4.4.3
Go Version:   go1.18.1
Built:        Thu Jan  1 00:00:00 1970
OS/Arch:      linux/amd64
root@ubuntu:~# runc --version
runc version 1.1.4-0ubuntu1~22.04.1
spec: 1.0.2-dev
go: go1.18.1
libseccomp: 2.5.3
```

## Note
The podman v4.4.3 package is not available in the official repository.

So i rebuild it at https://build.opensuse.org/package/show/home:ssst0n3/podman-v4.4.3 .