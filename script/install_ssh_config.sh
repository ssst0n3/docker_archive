#!/bin/bash
PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"

mkdir -p ~/.ssh/keys
cp ${PROJECT_DIR}/ssh_config/docker_archive ~/.ssh/keys/
cp ${PROJECT_DIR}/ssh_config/docker_archive_ecdsa-sha2-nistp256 ~/.ssh/keys/
sed -i '1i include '"${PROJECT_DIR}"'/ssh_config/config' ~/.ssh/config