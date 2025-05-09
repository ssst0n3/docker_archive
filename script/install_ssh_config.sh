#!/bin/bash
PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"

mkdir -p ~/.ssh/keys
cp ssh_config/docker_archive ~/.ssh/keys/
echo "include ${PROJECT_DIR}/ssh_config/config" >> ~/.ssh/config
