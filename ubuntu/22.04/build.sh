#!/bin/bash

alias d2vm="docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v \$PWD:/d2vm -w /d2vm linkacloud/d2vm:latest"
d2vm build -o vm.qcow2 . -v
