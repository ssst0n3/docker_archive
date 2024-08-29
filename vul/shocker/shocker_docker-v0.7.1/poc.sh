#!/bin/bash

set -ex

echo 'loading docker image, docker-v0.7.1 cannot pull images from registry v2 anymore.'

docker load < busybox-ubuntu-12.04.tar.gz
docker run -t -i busybox:ubuntu-12.04 grep Cap /proc/1/status
