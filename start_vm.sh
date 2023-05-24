#!/bin/bash
qemu-system-x86_64 \
-m 2560M \
-hda ubuntu-server-cloudimg.img \
-smp 2 \
-nographic \ 
-net nic -net user,hostfwd=tcp::22-:22,hostfwd=tcp::2345-:2345 \
-cpu host \
-enable-kvm $*