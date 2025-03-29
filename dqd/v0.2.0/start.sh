#!/bin/sh

CMD="qemu-system-x86_64 \
    -hda vm.qcow2 \
    -smp 2 \
    -m 2048M \
    -nographic"

CMD="$CMD -net nic -net user"

# setup ip
if [ -n "${QEMU_NET}" ]; then
    CMD="$CMD,net=${QEMU_NET}"
fi

if [ -n "${QEMU_DHCPSTART}" ]; then
    CMD="$CMD,dhcpstart=${QEMU_DHCPSTART}"
fi

# setup port forwarding
CMD="$CMD,hostfwd=tcp::22-:22"

if [ -n "${QEMU_HOSTFWD}" ]; then
    CMD="$CMD,${QEMU_HOSTFWD}"
fi

# setup kvm
if [ -e /dev/kvm ]; then
    CMD="$CMD -enable-kvm"
fi

exec $CMD "$@"