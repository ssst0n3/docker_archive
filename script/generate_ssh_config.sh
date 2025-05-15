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
#     IdentityFile <value>
#     StrictHostKeyChecking no
#     UserKnownHostsFile /dev/null
#
# If the .env file contains the IDENTITY_FILE variable, its value will be used as the
# IdentityFile. Otherwise, the default value ~/.ssh/keys/docker_archive is used.
#
# The output file is always ../ssh_config/config relative to the script’s directory,
# no matter where the script is executed from.
#
# Assumptions:
# - The .env file contains a line in the format: IMAGE=value or IMAGE="value".
# - The docker-compose.yml file includes a port mapping line like:
#       - "13239:22" or - 13239:22 (with or without quotes)
# - The host port is the number before the colon in the mapping "host_port:22".
# - The .env file may optionally include a line such as: IDENTITY_FILE=/path/to/key

# Determine the directory where this script is located.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_dir="$(dirname "$script_dir")"

# Define the absolute output file path relative to the script's location.
output_file="$project_dir/ssh_config/config"

# Create the output directory if it doesn't exist.
mkdir -p "$(dirname "$output_file")"

# Process each .env file found in the project directory and its subdirectories
find "$project_dir" -type f -name ".env" | sort | while IFS= read -r env_file; do
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

    # Extract the IDENTITY_FILE variable from the .env file if set, otherwise use the default.
    identity_file=$(grep '^IDENTITY_FILE=' "$env_file" | head -n1 | cut -d'=' -f2- | tr -d '"')
    if [ -z "$identity_file" ]; then
        identity_file="~/.ssh/keys/docker_archive"
    fi

    # Look for the port mapping in docker-compose.yml for container port 22.
    # Matches lines such as: - "13239:22" or - 13239:22
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

    # Construct the full configuration block as a multiline string.
    new_config=$(cat <<EOF
Host $image
    Hostname 127.0.0.1
    Port $host_port
    User root
    IdentityFile $identity_file
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
)

    # Check if an identical configuration block already exists in the output file.
    # Using awk with RS="" to treat blank lines as record separators.
    if [ -s "$output_file" ]; then
        if awk -v block="$new_config" 'BEGIN { RS=""; ORS="\n\n" }
        {
            # Remove any trailing newlines for reliable comparison.
            sub(/\n+$/, "", $0)
            if ($0 == block) { found=1; exit }
        }
        END { exit(found ? 0 : 1) }' "$output_file"; then
            # echo "Full configuration for [$image] already exists, skipping."
            continue
        fi
    fi

    # Append the SSH configuration block to the output file.
    {
        echo "$new_config"
        echo ""
    } >> "$output_file"

    echo "Added configuration for [$image] with ssh port: $host_port, identity_file: $identity_file"
done

echo "SSH configuration generated in: $output_file"
