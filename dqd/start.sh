#!/bin/bash

CMD="qemu-system-x86_64 \
    -hda vm.qcow2 \
    -smp 2 \
    -m 2048M \
    -nographic"

CMD+=" -net nic -net user"
if [ -n "${QEMU_NET}" ]; then
    CMD+=",net=${QEMU_NET}"
fi

if [ -n "${QEMU_DHCPSTART}" ]; then
    CMD+=",dhcpstart=${QEMU_DHCPSTART}"
fi

if [ -n "${QEMU_HOSTFWD}" ]; then
    CMD+=",hostfwd=tcp::22-:22,${QEMU_HOSTFWD}"
fi

if [ -e /dev/kvm ]; then
    CMD+=" -enable-kvm"
fi

exec $CMD "$@"