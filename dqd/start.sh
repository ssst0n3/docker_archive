#!/bin/bash

CMD="qemu-system-x86_64 \
    -hda vm.qcow2 \
    -smp 2 \
    -m 2048M \
    -nographic"

if [ -n "${QEMU_NET}" ] && [ -n "${QEMU_DHCPSTART}" ]; then
    CMD+=" -net nic -net user,net=${QEMU_NET},dhcpstart=${QEMU_DHCPSTART},hostfwd=tcp::22-:22,hostfwd=tcp::2345-:2345,hostfwd=tcp::2346-:2346"
else
    CMD+=" -net nic -net user,hostfwd=tcp::22-:22,hostfwd=tcp::2345-:2345,hostfwd=tcp::2346-:2346"
fi

if [ -e /dev/kvm ]; then
    CMD+=" -enable-kvm"
fi

# 执行最终命令
exec $CMD "$@"