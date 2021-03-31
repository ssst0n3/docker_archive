#!/bin/sh
qemu-system-x86_64 -m 2048 -net nic -net user -hda docker.qcow2 -nographic