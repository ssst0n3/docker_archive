#!/bin/sh
qemu-system-x86_64 -m 2048 -net nic -net user -hda root.qcow2 -hdb disk.qcow2 -nographic -enable-kvm
