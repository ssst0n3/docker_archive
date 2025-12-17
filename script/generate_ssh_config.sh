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
# The output file is always ../ssh_config/config relative to the script's directory,
# no matter where the script is executed from.
#
# To skip generating SSH config for a project, add SKIP_SSH_CONFIG=true to its .env file.
# When set, the script will silently skip that project without printing SKIP messages.
#
# Assumptions:
# - The .env file contains a line in the format: IMAGE=value or IMAGE="value".
# - The docker-compose.yml file includes a port mapping line like:
#       - "13239:22" or - 13239:22 (with or without quotes)
# - The host port is the number before the colon in the mapping "host_port:22".
# - The .env file may optionally include a line such as: IDENTITY_FILE=/path/to/key
# - The .env file may optionally include: SKIP_SSH_CONFIG=true to skip this project

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Determine the directory where this script is located.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_dir="$(dirname "$script_dir")"

# Define the absolute output file path relative to the script's location.
output_file="$project_dir/ssh_config/config"

# Create the output directory if it doesn't exist.
mkdir -p "$(dirname "$output_file")"

# Counter to track how many configurations were added
added_count=0

# Process each .env file found in the project directory and its subdirectories
# Use process substitution to avoid subshell, so we can track added_count
while IFS= read -r env_file; do
    # Get the directory containing the .env file.
    dir=$(dirname "$env_file")
    # Get relative path from project directory
    rel_dir="${dir#$project_dir/}"
    
    # Check if SKIP_SSH_CONFIG is set in the .env file
    # If set to true/1/yes, silently skip this project
    skip_ssh_config=$(grep '^SKIP_SSH_CONFIG=' "$env_file" | head -n1 | cut -d'=' -f2- | tr -d '"' | tr '[:upper:]' '[:lower:]')
    should_skip=false
    if [ -n "$skip_ssh_config" ]; then
        case "$skip_ssh_config" in
            true|1|yes|on)
                should_skip=true
                ;;
        esac
    fi
    
    # If SKIP_SSH_CONFIG is set, silently skip this project without any checks
    if [ "$should_skip" = true ]; then
        continue
    fi
    
    # Define the docker-compose.yml file path in the same directory.
    dc_file="$dir/docker-compose.yml"
    if [ ! -f "$dc_file" ]; then
        echo -e "${GRAY}[SKIP]${NC} ${GRAY}$rel_dir${NC} - ${GRAY}docker-compose.yml not found${NC}"
        continue
    fi

    # Extract the IMAGE variable from the .env file.
    # Assumes a format like: IMAGE=kubernetes-v1.32.3-calico or IMAGE="kubernetes-v1.32.3-calico"
    image=$(grep '^IMAGE=' "$env_file" | head -n1 | cut -d'=' -f2- | tr -d '"')
    if [ -z "$image" ]; then
        rel_env_file="${env_file#$project_dir/}"
        echo -e "${GRAY}[SKIP]${NC} ${GRAY}$rel_env_file${NC} - ${GRAY}IMAGE variable not found${NC}"
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
        rel_dc_file="${dc_file#$project_dir/}"
        echo -e "${GRAY}[SKIP]${NC} ${GRAY}$rel_dir${NC} - ${GRAY}No mapping for container port 22 found in $rel_dc_file${NC}"
        continue
    fi

    # Extract the host port (the number before the colon).
    host_port=$(echo "$port_line" | sed -E 's/.*"?([0-9]+):22"?[[:space:]]*$/\1/')
    if [ -z "$host_port" ]; then
        echo -e "${RED}[ERROR]${NC} ${RED}Failed to parse port mapping: $port_line${NC}"
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

    echo -e "${GREEN}[ADDED]${NC} ${GREEN}Host: ${CYAN}$image${NC}"
    echo -e "         ${GREEN}SSH Port: ${CYAN}$host_port${NC}"
    echo -e "         ${GREEN}Identity File: ${CYAN}$identity_file${NC}"
    ((added_count++))
done < <(find "$project_dir" -type f -name ".env" | sort)

rel_output_file="${output_file#$project_dir/}"
if [ "$added_count" -eq 0 ]; then
    echo -e "${YELLOW}[INFO]${NC} ${YELLOW}No new SSH configurations were added${NC}"
    echo -e "          ${YELLOW}Output file: ${CYAN}$rel_output_file${NC}"
    echo -e "          ${GRAY}(All configurations already exist or no valid configurations found)${NC}"
else
    echo -e "${BLUE}[SUCCESS]${NC} ${BLUE}SSH configuration generated${NC}"
    echo -e "          ${BLUE}Output file: ${CYAN}$rel_output_file${NC}"
    echo -e "          ${BLUE}Added ${CYAN}$added_count${BLUE} configuration(s)${NC}"
fi
