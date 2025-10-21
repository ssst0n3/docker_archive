#!/bin/bash
docker buildx create --driver-opt "network=docker-archive-bridge" --name docker-archive-builder2 --buildkitd-flags "--allow-insecure-entitlement security.insecure"
docker buildx build --no-cache --add-host kubernetes-1-34-0:10.0.2.16 --build-arg BUILDKIT_SANDBOX_HOSTNAME=kubernetes-1-34-0-worker --progress=plain --builder docker-archive-builder2 --allow security.insecure --load -t $1 .
