#!/bin/bash

CMD="qemu-system-x86_64 \
-hda vm.qcow2 \
-smp 2 \
-m 2048M \
-nographic \
-net nic -net user,hostfwd=tcp::22-:22,hostfwd=tcp::2345-:2345,hostfwd=tcp::2346-:2346"

if [ -e /dev/kvm ]; then
    CMD+=" -enable-kvm"
fi

$CMD "$@"