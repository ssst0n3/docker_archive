---

version: v0.1.1

---

# Specification

## disable auto-upgrades 

Do it during basic image.

```
sed -i s/1/0/g /etc/apt/apt.conf.d/20auto-upgrades
```

## enable cloud-init

Do it during basic image.

```
#!/usr/bin/expect -f
set timeout -1
spawn qemu-system-x86_64 \
    -hda ubuntu-server-cloudimg.img \
    -nographic \
    -smp 2 \
    -m 2048M

send "\r"
expect "login:"
send "root\r"
expect "assword:"
send "root\r"
expect "#"
send "rm /etc/cloud/cloud-init.disabled\r"
expect "#"
send "shutdown now \r"

interact
```


## sync

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

## shrunk

### remove redundant files

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

### shrunk the image file

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

## document

### branch main

| tag | alias | spec | note |
| --- | --- | --- | --- |
| `[tag](link)` | alias in lower format | vx.x.x | note |

### branch release

* how to use
* troubleshouting [optional]