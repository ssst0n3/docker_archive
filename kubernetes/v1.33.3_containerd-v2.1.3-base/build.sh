#!/bin/bash
set -euo pipefail

# ============================================================================
# Configuration - modify as needed
# ============================================================================
SANDBOX_HOSTNAME="kubernetes-1-33-3-containerd-2-1-3"
NETWORK_NAME="docker-archive-bridge"
NETWORK_SUBNET="10.0.2.0/24"
NETWORK_IP_RANGE="10.0.2.16/28"
NETWORK_GATEWAY="10.0.2.1"
BUILDER_NAME="docker-archive-builder"

# ============================================================================
# Functions
# ============================================================================

# Create custom network (for buildx)
# https://docs.docker.com/build/builders/drivers/docker-container/#custom-network
create_network() {
    docker network create \
        --subnet "${NETWORK_SUBNET}" \
        --ip-range "${NETWORK_IP_RANGE}" \
        --gateway "${NETWORK_GATEWAY}" \
        "${NETWORK_NAME}" 2>/dev/null || true
}

# Create buildx builder
create_builder() {
    docker buildx create \
        --driver-opt "network=${NETWORK_NAME}" \
        --name "${BUILDER_NAME}" \
        --buildkitd-flags "--allow-insecure-entitlement security.insecure" \
        2>/dev/null || true
}

# Prune buildx cache
prune_cache() {
    docker buildx --builder "${BUILDER_NAME}" prune \
        --filter type=exec.cachemount -f || true
}

# Execute Docker buildx build
execute_build() {
    local image_tag="${1:?Error: Please provide image tag, e.g.: ./build.sh myimage:tag}"
    local progress_opt=""
    
    # Determine progress option based on DEBUG environment variable
    if [[ "${DEBUG:-}" == "true" ]] || [[ "${DEBUG:-}" == "1" ]] || [[ "${DEBUG:-}" == "yes" ]]; then
        progress_opt="--progress=plain"
    fi

    docker buildx build \
        --builder "${BUILDER_NAME}" \
        --build-arg CACHE_BUST=$(date +%s) \
        --build-arg BUILDKIT_SANDBOX_HOSTNAME="${SANDBOX_HOSTNAME}" \
        ${progress_opt} \
        --allow security.insecure \
        --load \
        -t "${image_tag}" \
        .
}

# ============================================================================
# Script entry point
# ============================================================================
create_network
create_builder
prune_cache
execute_build "${1}"
