#!/bin/bash
mkdir -p ~/.ssh/keys
cp ssh_config/docker_archive ~/.ssh/keys/
echo "include $(pwd)/ssh_config/config" >> ~/.ssh/config