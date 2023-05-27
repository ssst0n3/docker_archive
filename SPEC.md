---

version: v0.3.0

---

# Specification

## Image Hierarchy

| Hierarchy | Description | e.g. |
| --- | --- | --- |
| Basic | mainly provide the clean vm image | [build_basic_ubuntu-20.04](https://github.com/ssst0n3/docker_archive/tree/build_basic_ubuntu-20.04) |
| | | [release_basic_ubuntu-20.04](https://github.com/ssst0n3/docker_archive/tree/release_basic_ubuntu-20.04) |
| Preliminary | doing some pre works such as disable auto-upgrades, slim the image, etc. | [pre_ubuntu-20.04](https://github.com/ssst0n3/docker_archive/tree/pre_ubuntu-20.04) |
| Release | | [branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1](https://github.com/ssst0n3/docker_archive/tree/branch_ubuntu-20.04_docker-ce-19.03.11_containerd.io-1.4.9_runc-1.0.1) |

## Every Hierarchy

### container image version management

tag: `os-version_container-software-version_image-version`

The `os-version_container-software-version` is the alias of the newest `os-version_container-software-version_image-version`.

### sync

sync before shutdown.

init_qemu.expect

```
#!/usr/bin/expect -f
set timeout -1
spawn qemu-system-x86_64 \
    -hda ubuntu-server-cloudimg.img \
    -hdb cloud.img \
    -nographic \
    -smp 2 \
    -m 2048M

expect -re {init.sh complete}

send "\r"
expect "login:"
send "root\r"
expect "assword:"
send "root\r"
expect "#"
send "sync\r"
expect "#"
send "shutdown now \r"

interact
```

### shrunk

#### remove redundant files

cloud.txt

```
...
- content: |
    #!/bin/bash
    apt purge snapd
    apt clean
    sync
  path: /tmp/clean.sh
  permissions: '0755'
- content: |
    #!/bin/bash
    set -ex
    wget -q https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
    ...
    rm -f /go1.20.4.linux-amd64.tar.gz
    /tmp/clean.sh
    ...
  path: /tmp/init.sh
  permissions: '0755'
...
```

#### shrunk the image file

For each image:

Execute shrunk.sh after build stage.

Dockerfile

```
FROM <build-basic-image> AS build-stage
...
RUN apt update && apt install -y libguestfs-tools linux-image-generic && apt clean
COPY shrunk.sh /shrunk.sh
RUN /shrunk.sh /ubuntu-server-cloudimg.img

FROM <release-image>
COPY --from=build-stage /ubuntu-server-cloudimg.img /
...
```

shrunk.sh

```
#!/bin/bash
set -ex
source=$1
virt-sparsify --compress $source shrunk.img
mv shrunk.img $source
```

#### shutdown when `init.sh complete`

init_qemu.expect

```
...
expect -re {init.sh complete}

send "\r"
expect "login:"
send "root\r"
expect "assword:"
send "root\r"
expect "#"
send "sync\r"
expect "#"
send "shutdown now \r"

interact
```

### project name

.env

```
COMPOSE_PROJECT_NAME=pre_ubuntu-20.04
```

## Preliminary

### disable auto-upgrades 

```
sed -i s/1/0/g /etc/apt/apt.conf.d/20auto-upgrades
```

### sshd config

```
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
```

### clean

```
apt purge -y snapd
apt autoremove -y
apt clean
```

### change passwd

cloud.txt

```
user: root
password: root
chpasswd: {expire: False}
ssh_pwauth: True
```

## document

### branch main

| tag | alias | spec | note |
| --- | --- | --- | --- |
| `[tag](link)` | alias in lower format | vx.x.x | note |

### branch release

```
---

spec-version: v0.2.3
hierarchy: basic/preliminary/release
image-version: v0.1.0

---

## how to use
## troubleshouting [optional]
```
