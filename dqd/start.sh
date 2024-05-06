#!/bin/bash
qemu-system-x86_64 \
-hda vm.qcow2 \
-smp 2 \
-m 2048M \
-nographic $*
# -net nic -net user,hostfwd=tcp::22-:22