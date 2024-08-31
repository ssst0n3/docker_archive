#!/bin/bash

set -ex

wget -q https://github.com/ctrsploit/ctrsploit/releases/latest/download/ctrsploit_linux_amd64 -O ctrsploit && chmod +x ctrsploit
docker run -tid --name poc --cap-add CAP_DAC_READ_SEARCH busybox
docker cp ctrsploit poc:/usr/bin/
docker attach poc