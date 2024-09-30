#!/bin/bash

echo 'prepare env'

mkdir -p rootfs/bin/
cp /bin/busybox rootfs/bin/
ln -s /bin/busybox rootfs/bin/sh
ln -s /bin/busybox rootfs/bin/sleep
runc spec
sed -i '/"type": "pid"/{N;N;d;}' config.json
sed -i 's/"sh"/"\/bin\/sleep", "20"/' config.json

echo "please run 'runc run container-1' @ terminal1"
echo "run 'runc exec container-1 sleep 9999' @ terminal2"
