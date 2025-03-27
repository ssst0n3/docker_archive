#!/bin/bash
# docker buildx rm insecure-builder
# docker buildx create --name insecure-builder --buildkitd-flags "--allow-insecure-entitlement security.insecure"
docker buildx build --build-arg BUILDKIT_SANDBOX_HOSTNAME=kind-control-plane --progress=plain --builder insecure-builder --allow security.insecure --load -t $1 .
