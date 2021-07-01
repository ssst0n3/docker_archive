#!/bin/bash
linuxkit build -size 10G -disable-content-trust -format qcow2-bios docker.yml
./shrunk.sh docker.qcow2
