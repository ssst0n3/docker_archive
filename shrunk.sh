#!/bin/bash
set -ex
source=$1
qemu-img convert -c -O qcow2 $source shrunk.img
mv shrunk.img $source
