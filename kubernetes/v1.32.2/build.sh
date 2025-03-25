#!/bin/bash
docker buildx build --network=docker_archive --build-arg BUILDKIT_SANDBOX_HOSTNAME=kind-control-plane --progress=plain --builder insecure-builder --allow security.insecure --load -t $1 .
