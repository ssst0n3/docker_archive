#!/bin/bash
set -x
# fix kube-proxy `write /sys/module/nf_conntrack/parameters/hashsize: operation not supported`
# https://blog.michali.net/2017/08/09/ipv6-support-for-docker-in-docker/
# https://github.com/kubernetes/kubernetes/blob/v1.18.2/cmd/kube-proxy/app/conntrack.go#L60-L66
PARAM_PATH="/sys/module/nf_conntrack/parameters/hashsize"
SYSCTL_PATH="/proc/sys/net/netfilter/nf_conntrack_max"
MAX=$(< "$SYSCTL_PATH")
HASH_SIZE=$(( MAX / 4 ))
echo "$HASH_SIZE" > "$PARAM_PATH"

# https://docs.docker.com/build/builders/drivers/docker-container/#custom-network
docker network create --subnet 10.0.2.0/24 --ip-range 10.0.2.16/28 --gateway 10.0.2.1 docker-archive-bridge
docker buildx create --driver-opt "network=docker-archive-bridge" --name docker-archive-builder \
    --buildkitd-flags "--allow-insecure-entitlement security.insecure"

docker buildx --builder docker-archive-builder prune --filter type=exec.cachemount -f || true
cp /lib/modules modules -r
docker buildx build \
    --build-arg BUILDKIT_SANDBOX_HOSTNAME=kubernetes-1-18-2 \
    --progress=plain --builder docker-archive-builder \
    --allow security.insecure \
    --load -t $1 .
rm modules -r