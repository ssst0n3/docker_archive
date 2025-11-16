#!/bin/bash

# ==============================================================================
#
# Script: sync_docker_images.sh
#
# Description: This script recursively finds 'docker-compose.yml' files,
#              pulls the images defined within them, tags them for a new
#              mirror registry, pushes them, and generates a corresponding
#              mirror compose file.
#
#              The script correctly handles both short image names (e.g., nginx:latest)
#              and fully-qualified image names (e.g., docker.io/library/nginx:latest).
#              It extracts the base image name and tag before prepending the
#              mirror registry prefix.
#
#              The generated mirror compose file will only contain the 'image'
#              field for each service.
#
#              If a mirror compose file already exists in a directory,
#              the script will skip processing for that directory.
#
# Prerequisites:
#   - docker: Must be installed, running, and logged into the MIRROR_REGISTRY.
#   - yq: A command-line YAML processor .
#
# Usage:
#   export MIRROR_REGISTRY="your-registry.com/your-project"
#   export MIRROR_VENDOR="internal"
#   ./sync_docker_images.sh
#
# ==============================================================================


# --- Script Configuration and Safety ---
# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u
# Pipelines return the exit status of the last command to exit with a
# non-zero status, or zero if all commands exit successfully.
set -o pipefail


# --- Function Definitions ---

##
# @brief Checks for required environment variables and command-line tools.
# @description Exits the script with an error message if any dependency is missing.
##
check_prerequisites() {
    echo "1. Checking prerequisites..."

    # Check if required environment variables are set.
    if [ -z "${MIRROR_REGISTRY-}" ] || [ -z "${MIRROR_VENDOR-}" ]; then
        echo "   [Error] MIRROR_REGISTRY and MIRROR_VENDOR environment variables must be set." >&2
        echo "   Usage: export MIRROR_REGISTRY=\"your-registry.com/your-project\"" >&2
        echo "          export MIRROR_VENDOR=\"internal\"" >&2
        echo "          ./sync_docker_images.sh" >&2
        exit 1
    fi

    # Check if yq is installed.
    if ! command -v yq &> /dev/null; then
        echo "   [Error] yq is not installed. Please install it to continue." >&2
        echo "   See: https://github.com/mikefarah/yq/" >&2
        exit 1
    fi
    
    # Check if docker is installed.
    if ! command -v docker &> /dev/null; then
        echo "   [Error] docker is not installed. Please install it to continue." >&2
        exit 1
    fi

    echo "   -> All prerequisites are met."
}

##
# @brief Pulls, tags, and pushes a single Docker image to the mirror registry.
# @param $1 The original image name (e.g., "docker.io/library/nginx:latest").
##
process_image() {
    local original_image="$1"
    
    # Skip if the image name is empty
    if [ -z "$original_image" ]; then
        return
    fi

    echo "  [Image] => ${original_image}"
    
    # Extract the base image name and tag from the original image string.
    # This removes any existing registry/project prefix.
    # Example: 'docker.io/library/nginx:latest' becomes 'nginx:latest'.
    # Example: 'nginx:latest' remains 'nginx:latest'.
    local base_image_name="${original_image##*/}"
    
    # Define the new image name for the mirror registry.
    local mirror_image="${MIRROR_REGISTRY}/${base_image_name}"

    # 1. Pull the original image from its source registry.
    echo "    -> Pulling..."
    docker pull "${original_image}"

    # 2. Tag the image for the mirror registry.
    echo "    -> Tagging as ${mirror_image}"
    docker tag "${original_image}" "${mirror_image}"

    # 3. Push the newly tagged image to the mirror registry.
    echo "    -> Pushing..."
    docker push "${mirror_image}"

    echo "    -> Done."
}

##
# @brief Processes a single docker-compose.yml file.
# @description Extracts images, processes them, and generates a mirror compose file.
#              Skips processing if the mirror file already exists or if no images are found.
# @param $1 The path to the docker-compose.yml file.
##
process_compose_file() {
    local compose_file="$1"
    echo "--- Processing file: ${compose_file} ---"

    # Get the directory of the compose file.
    local dir
    dir=$(dirname "${compose_file}")
    
    # Define the path for the new mirror compose file.
    local mirror_file="${dir}/docker-compose.${MIRROR_VENDOR}-mirror.yml"

    # If the mirror file already exists, skip this entire directory.
    if [ -f "${mirror_file}" ]; then
        echo "-> Mirror file '${mirror_file}' already exists. Skipping."
        echo "" # Add a blank line for better readability
        return 0 # Exit this function successfully and continue to the next file.
    fi

    # Use yq to extract all image names.
    # The `|| true` prevents the script from exiting if no images are found.
    local images
    images=$(yq '.services[].image | select(. != null)' -r "${compose_file}" || true)

    # If the 'images' variable is empty, it means no 'image:' keys were found.
    # In this case, we skip processing this file entirely and do not create a mirror file.
    if [ -z "$images" ]; then
        echo "-> No images found in ${compose_file}. Skipping file creation."
        echo "" # Add a blank line for better readability
        return 0 # Exit this function successfully, moving to the next file.
    fi

    # Process each image using the dedicated function.
    # This block is now only executed if images were found.
    echo "$images" | while IFS= read -r original_image; do
        process_image "${original_image}"
    done

    # After processing all images, generate the new docker-compose-mirror.yml.
    # This block is also now only executed if images were found.
    echo "-> Generating mirror compose file: ${mirror_file}"
    
    # The yq expression now also extracts the base image name before prepending the new registry.
    # It splits the image path by '/' and takes the last element (the image name + tag).
    # Then, it constructs the new image path and uses 'pick' to create a new service
    # definition containing ONLY the 'image' field.
    MIRROR_REGISTRY="${MIRROR_REGISTRY}" yq '.services[] |= ((.image |= (env(MIRROR_REGISTRY) + "/" + (. | split("/") | .[-1]))) | pick(["image"]))' "${compose_file}" > "${mirror_file}"

    echo "--- Finished processing: ${compose_file} ---"
    echo "" # Add a blank line for better readability in the output.
}

##
# @brief Main function to orchestrate the synchronization process.
##
make_mirror() {
    check_prerequisites

    echo "2. Starting to find and process docker-compose.yml files..."
    
    # Use `find` with `-print0` and `read -d ''` for safe handling of filenames
    # with spaces or special characters.
    find . -type f -name "docker-compose.yml" -print0 | while IFS= read -r -d $'\0' compose_file; do
        process_compose_file "${compose_file}"
    done

    echo "All docker-compose files have been processed successfully."
}

# --- Main Execution ---
make_mirror