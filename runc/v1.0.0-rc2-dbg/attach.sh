#!/bin/bash
dlv --listen=:2347 --headless=true --api-version=2 --accept-multiclient attach $1