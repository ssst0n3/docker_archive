#!/bin/bash
set -e

PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
SSH_DIR=~/.ssh
KEYS_DIR=${SSH_DIR}/keys
CONFIG_FILE=${SSH_DIR}/config
INCLUDE_CONFIG_PATH="${PROJECT_DIR}/ssh_config/config"
INCLUDE_LINE="Include ${INCLUDE_CONFIG_PATH}"

mkdir -p "${KEYS_DIR}"
cp "${PROJECT_DIR}/ssh_config/docker_archive" "${KEYS_DIR}/"
cp "${PROJECT_DIR}/ssh_config/docker_archive_ecdsa-sha2-nistp256" "${KEYS_DIR}/"
chmod -c 600 "${PROJECT_DIR}/ssh_config/docker_archive*"

# Ensure the config file exists
touch "${CONFIG_FILE}"

# Prepend the include line if it's not already there
if ! grep -qF -- "${INCLUDE_LINE}" "${CONFIG_FILE}"; then
  TMP_FILE=$(mktemp)
  echo "${INCLUDE_LINE}" > "${TMP_FILE}"
  cat "${CONFIG_FILE}" >> "${TMP_FILE}"
  mv "${TMP_FILE}" "${CONFIG_FILE}"
fi
