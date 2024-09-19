#!/bin/bash
dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient exec /usr/local/sbin/runc-v1.0.0-rc3-debug-flag -- $*