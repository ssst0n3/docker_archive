#!/bin/bash
qemu-system-x86_64 \
-m 1024 \
-hda ubuntu-server-cloudimg.img \
-net nic -net user,hostfwd=tcp::22-:22 \
-smp 2 \
-m 2048M \
-nographic $*