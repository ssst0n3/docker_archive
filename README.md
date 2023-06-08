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
$ docker run -ti --name runc-1-0-0-rc3 ssst0n3/docker_archive:ubuntu-20.04_runc-1.0.0-rc3_v0.1.0
...
Ubuntu 20.04 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# runc --version
```

#### 1.2 tty with detach

```
$ docker run -tid --name runc-1-0-0-rc3 ssst0n3/docker_archive:ubuntu-20.04_runc-1.0.0-rc3_v0.1.0
$ docker attach --detach-keys ctrl-x runc-1-0-0-rc3
...
Ubuntu 20.04 LTS ubuntu ttyS0

ubuntu login: root
Password: root
root@ubuntu:~# runc --version
```

### 2. ssh

#### Step1: Get the compose file to start the environment

##### a) ssh without kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_runc-1.0.0-rc3
$ docker compose -f docker-compose.yml up -d
```

or 

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_runc-1.0.0-rc3_v0.1.0
    ports:
        - "1003:22"
    tty: true
    stdin_open: true 
EOF
$ docker compose -p runc-1-0-0-rc3 up -d
```

##### b) ssh with kvm

```
$ git clone https://github.com/ssst0n3/docker_archive.git
$ cd docker_archive
$ git checkout branch_ubuntu-20.04_runc-1.0.0-rc3
$ docker compose -f docker-compose.kvm.yml up -d
```

or

```
$ mkdir docker && cd docker
$ cat > docker-compose.yml << EOF
version: '3'
services:
  vm:
    image: ssst0n3/docker_archive:ubuntu-20.04_runc-1.0.0-rc3_v0.1.0
    ports:
      - "1003:22"
    command: /start_vm.sh -enable-kvm
    devices:
      - "/dev/kvm:/dev/kvm"
    tty: true
    stdin_open: true
EOF
$ docker compose -p runc-1-0-0-rc3 up -d
```

#### Step2: Wait for vm starting
Wait for vm starting. You can use docker logs -f to watch the starting progress.

#### Step3: Enter the environemnt
Then ssh into the vm with kata installed:

```
$ ssh -p 1003 root@127.0.0.1
root@127.0.0.1's password: root
root@ubuntu:~# runc --version
```

## version

* `ubuntu-20.04_runc-1.0.0-rc3`
* `ubuntu-20.04_runc-1.0.0-rc3_v0.1.0`

```
root@ubuntu:~# runc --version
runc version 1.0.0-rc3
commit: -dirty
spec: 1.0.0-rc5
```