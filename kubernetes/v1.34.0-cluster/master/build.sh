#!/bin/bash
# https://docs.docker.com/build/builders/drivers/docker-container/#custom-network
docker network create --subnet 10.0.2.0/24 --ip-range 10.0.2.16/28 --gateway 10.0.2.1 docker-archive-bridge
docker buildx create --driver-opt "network=docker-archive-bridge" --name docker-archive-builder --buildkitd-flags "--allow-insecure-entitlement security.insecure"
docker buildx build --no-cache --build-arg BUILDKIT_SANDBOX_HOSTNAME=kubernetes-1-34-0 --progress=plain --builder docker-archive-builder --allow security.insecure --load -t $1 .
