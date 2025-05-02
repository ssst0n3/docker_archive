#!/bin/bash
set -ex
find . -name "vm.qcow2" -type f -exec rm -i {} \;