#!/bin/bash
set -x

# fix kube-proxy `write /sys/module/nf_conntrack/parameters/hashsize: operation not supported`
# https://blog.michali.net/2017/08/09/ipv6-support-for-docker-in-docker/
# https://github.com/kubernetes/kubernetes/blob/v1.18.2/cmd/kube-proxy/app/conntrack.go#L60-L66
fix_nf_conntrack_hashsize() {
  local PARAM_PATH="/sys/module/nf_conntrack/parameters/hashsize"
  local SYSCTL_PATH="/proc/sys/net/netfilter/nf_conntrack_max"

  if [[ ! -e "$PARAM_PATH" || ! -e "$SYSCTL_PATH" ]]; then
    echo "Error: missing system path." >&2
    return 1
  fi

  local MAX TARGET_HASHSIZE CURRENT_HASHSIZE
  MAX=$(< "$SYSCTL_PATH")
  TARGET_HASHSIZE=$(( MAX / 4 ))
  CURRENT_HASHSIZE=$(< "$PARAM_PATH")

  if (( CURRENT_HASHSIZE < TARGET_HASHSIZE )); then
    echo "Updating nf_conntrack hashsize to $TARGET_HASHSIZE"
    echo "$TARGET_HASHSIZE" > "$PARAM_PATH"
  else
    echo "Current hashsize ($CURRENT_HASHSIZE) is sufficient"
  fi
}

fix_nf_conntrack_hashsize

# https://docs.docker.com/build/builders/drivers/docker-container/#custom-network
docker network create --subnet 10.0.2.0/24 --ip-range 10.0.2.16/28 --gateway 10.0.2.1 docker-archive-bridge
docker buildx create --driver-opt "network=docker-archive-bridge" --name docker-archive-builder --buildkitd-flags "--allow-insecure-entitlement security.insecure"
docker buildx --builder docker-archive-builder prune --filter type=exec.cachemount -f
mkdir -p modules
cp /lib/modules/$(uname -r) modules/$(uname -r) -r
docker buildx build \
    --build-arg BUILDKIT_SANDBOX_HOSTNAME=kubernetes-1-18-2 \
    --progress=plain \
    --builder docker-archive-builder \
    --allow security.insecure \
    --load -t $1 .
rm modules -r