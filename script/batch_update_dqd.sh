#!/bin/bash

set -ex

targets=(
"vul/cve-2025-1974"
"vul/shocker/shocker_docker-v0.7.1"
"vul/shocker/shocker_docker-v0.7.2"
"vul/shocker/shocker_docker-v0.9.0"
"vul/shocker/shocker_docker-v0.9.0-lxc"
"vul/shocker/shocker_docker-v0.11.1"
"vul/shocker/shocker_docker-v0.11.1-lxc"
"vul/shocker/shocker_docker-v0.12.0"
"vul/shocker/shocker_docker-v0.12.0-lxc"
"vul/shocker/shocker_docker-v1.0.0-lxc"
"vul/shocker/shocker_docker-v1.0.1-lxc"
"vul/shocker/shocker_docker-v26.1.4"
)

for target in "${targets[@]}"; do
  make vm dqd push DIR="./${target}"
done

