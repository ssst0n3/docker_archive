#!/bin/bash

CMD="qemu-system-x86_64 \
    -hda vm.qcow2 \
    -smp 2 \
    -m 2048M \
    -nographic"

CMD+=" -net nic -net user"

# setup ip
if [ -n "${QEMU_NET}" ]; then
    CMD+=",net=${QEMU_NET}"
fi

if [ -n "${QEMU_DHCPSTART}" ]; then
    CMD+=",dhcpstart=${QEMU_DHCPSTART}"
fi

# setup port forwarding
CMD+=",hostfwd=tcp::22-:22"

if [ -n "${QEMU_HOSTFWD}" ]; then
    CMD+=",${QEMU_HOSTFWD}"
fi

# setup kvm
if [ -e /dev/kvm ]; then
    CMD+=" -enable-kvm"
fi

exec $CMD "$@"