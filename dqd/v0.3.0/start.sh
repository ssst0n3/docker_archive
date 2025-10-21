#!/bin/sh
set -eu  # Exit on error or use of undefined variable

build_default_net_args() {
    local opts="-nic user"

    # setup ip
    [ -n "${QEMU_NET:-}" ] && opts="${opts},net=${QEMU_NET}"
    [ -n "${QEMU_DHCPSTART:-}" ] && opts="${opts},dhcpstart=${QEMU_DHCPSTART}"

    # Always enable SSH port forwarding
    opts="${opts},hostfwd=tcp::22-:22"

    # Additional port forwarding, if defined
    [ -n "${QEMU_HOSTFWD:-}" ] && opts="${opts},${QEMU_HOSTFWD}"

    echo "$opts,model=virtio"
}

# Build dual-network arguments (socket-based)
build_dual_net_args() {
    local opts="-nic socket"

    [ -n "${QEMU_SOCKET_LISTEN:-}" ] && opts="${opts},listen=${QEMU_SOCKET_LISTEN}"
    [ -n "${QEMU_SOCKET_CONNECT:-}" ] && opts="${opts},connect=${QEMU_SOCKET_CONNECT}"

    echo "$opts,model=virtio"
}

build_cloudinit_args() {
#     cat > /user-data <<EOF
# #cloud-config
# runcmd:
#   - ip addr add ${QEMU_SOCKET_IP}/24 dev eth1
#   - ip link set eth1 up
# EOF

# setup optional=true to prevent network-online.target stuck 
    cat > /network-config <<EOF
network:
  version: 2
  ethernets:
    eth1:
      dhcp4: false
      addresses:
        - ${QEMU_SOCKET_IP}/24
      optional: true
EOF
    cloud-localds --network-config=/network-config /seed.img /dev/null
    echo "-drive file=/seed.img,if=virtio,format=raw"
}

CMD="qemu-system-x86_64 \
    -hda vm.qcow2 \
    -smp 2 \
    -m 2048M \
    -nographic"

CMD="$CMD $(build_default_net_args)"

if [ -n "${QEMU_DUAL_NET:-}" ]; then
    CMD="$CMD $(build_dual_net_args)"
fi

if [ -n "${QEMU_SOCKET_IP:-}" ]; then
    CMD="$CMD $(build_cloudinit_args)"
fi

# setup kvm
if [ -e /dev/kvm ]; then
    CMD="$CMD -enable-kvm"
fi

exec $CMD "$@"