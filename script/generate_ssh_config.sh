#!/bin/bash
# This script generates an ssh_config file based on configuration files found 
# in the current working directory and its subdirectories.
#
# For every directory that contains a .env file, the script does the following:
# 1. Extracts the IMAGE variable from the .env file (used as the Host value in ssh_config).
# 2. Verifies that a docker-compose.yml exists in the same directory.
# 3. Searches docker-compose.yml for a port mapping where the container port 22 is mapped,
#    and extracts the host port from it.
# 4. Appends an entry to the ssh_config file in the following format:
#
# Host <IMAGE>
#     Hostname 127.0.0.1
#     Port <HOST_PORT>
#     User root
#     IdentityFile ~/.ssh/keys/docker_archive
#
# The output file is always ../ssh_config/config relative to the script’s directory,
# no matter where the script is executed from.
#
# Assumptions:
# - The .env file contains a line in the format: IMAGE=value or IMAGE="value".
# - The docker-compose.yml file includes a port mapping line like:
#       - "13239:22" or - 13239:22 (with or without quotes)
# - The host port is the number before the colon in the mapping "host_port:22".

# Determine the directory where this script is located.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the absolute output file path relative to the script's location.
output_file="$script_dir/../ssh_config/config"

# Create the output directory if it doesn't exist.
mkdir -p "$(dirname "$output_file")"

# Clear the output file.
> "$output_file"

# Find all .env files in the current working directory and its subdirectories,
# even if the script is executed from a different directory.
find . -type f -name ".env" | while IFS= read -r env_file; do
    # Get the directory containing the .env file.
    dir=$(dirname "$env_file")
    
    # Define the docker-compose.yml file path in the same directory.
    dc_file="$dir/docker-compose.yml"
    if [ ! -f "$dc_file" ]; then
        echo "Skipping directory $dir: docker-compose.yml not found."
        continue
    fi

    # Extract the IMAGE variable from the .env file.
    # Assumes a format like: IMAGE=kubernetes-v1.32.3-calico or IMAGE="kubernetes-v1.32.3-calico"
    image=$(grep '^IMAGE=' "$env_file" | head -n1 | cut -d'=' -f2- | tr -d '"')
    if [ -z "$image" ]; then
        echo "IMAGE variable not found in $env_file, skipping this directory."
        continue
    fi

    # Look for the port mapping in docker-compose.yml for container port 22.
    # Matches lines such as: - "13239:22" or - 13239:22
    # port_line=$(grep -E '^[[:space:]]*-[[:space:]]*"?[0-9]+:22"?[[:space:]]*$' "$dc_file")
    port_line=$(sed -n 's/.*"\([0-9]\+\):22".*/\1/p' "$dc_file")
    if [ -z "$port_line" ]; then
        echo "No mapping for container port 22 found in $dc_file, skipping directory $dir."
        continue
    fi

    # Extract the host port (the number before the colon).
    host_port=$(echo "$port_line" | sed -E 's/.*"?([0-9]+):22"?[[:space:]]*$/\1/')
    if [ -z "$host_port" ]; then
        echo "Failed to parse port mapping: $port_line."
        continue
    fi

    # Append the SSH configuration entry to the output file.
    {
        echo "Host $image"
        echo "    Hostname 127.0.0.1"
        echo "    Port $host_port"
        echo "    User root"
        echo "    IdentityFile ~/.ssh/keys/docker_archive"
        echo ""
    } >> "$output_file"

    echo "Added configuration for [$image] with ssh port: $host_port."
done

echo "SSH configuration generated in: $output_file"
