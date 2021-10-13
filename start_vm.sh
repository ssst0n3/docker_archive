#!/bin/bash
qemu-system-x86_64 \
-m 1024 \
-hda ubuntu-server-cloudimg.img \
-net nic -net user,hostname=host,hostfwd=tcp::22-:22 \
-smp 2 \
-m 2048M \
-nographic


# qemu-system-x86_64 \
#     -smp 2 \
#     -m 1024 \
#     -nographic \
#     -hda ubuntu-20.04-server-cloudimg-amd64.img \
#     -hdb cloud.img \
#     -netdev user,id=cpu,hostfwd=tcp::2222-:22
    # -enable-kvm
