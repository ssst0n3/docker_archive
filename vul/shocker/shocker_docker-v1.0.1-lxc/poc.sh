#!/bin/bash

set -ex

echo 'loading docker image, docker-v1.0.1 cannot pull images from registry v2 anymore.'

docker load < busybox-1.36.1.tar.gz
docker run -ti busybox:1.36.1 grep Cap /proc/1/status
