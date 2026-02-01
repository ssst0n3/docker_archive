#!/bin/bash
set -euo pipefail

# ============================================================================
# Configuration - modify as needed
# ============================================================================
SANDBOX_HOSTNAME="kubernetes-1-33-7"
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

# Prepare kernel modules
prepare_modules() {
    local kernel_version
    kernel_version=$(uname -r)
    mkdir -p modules
    cp "/lib/modules/${kernel_version}" "modules/${kernel_version}" -r
}

# Cleanup kernel modules
cleanup_modules() {
    rm -rf modules
}

# make sure fs.inotify.max_user_instances >= 512
# https://kind.sigs.k8s.io/docs/user/known-issues/#pod-errors-due-to-too-many-open-files
fix_too_many_open_files() {
    local max_user_instances
    max_user_instances=$(cat /proc/sys/fs/inotify/max_user_instances 2>/dev/null || echo 0)
    if [[ "${max_user_instances}" -lt 512 ]]; then
        echo "Warning: fs.inotify.max_user_instances is ${max_user_instances}, should be at least 512"
        echo "Consider running: sudo sysctl -w fs.inotify.max_user_instances=512"
    fi
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
prepare_modules
fix_too_many_open_files
execute_build "${1}"
cleanup_modules