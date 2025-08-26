#!/usr/bin/env bash
target=$(basename "$0")
case "$target" in
    buildkitd)
        port=2345
        ;;
    *)
        echo "unknown target: $target"
        exit 1
        ;;
esac

exec dlv --listen=":${port}" \
         --headless=true \
         --api-version=2 \
         --accept-multiclient \
         exec "/root/bin/${target}.debug" -- "$@"
