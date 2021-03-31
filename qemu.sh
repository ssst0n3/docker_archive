#!/bin/bash
qemu-img create -f qcow2 disk.qcow2 10G
qemu-system-x86_64 -m 2048 -net nic -net user -hda docker.qcow2 -hdb disk.qcow2 -nographic -enable-kvm