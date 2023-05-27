#!/bin/bash
set -ex
source=$1
virt-sparsify --compress $source shrunk.img
mv shrunk.img $source