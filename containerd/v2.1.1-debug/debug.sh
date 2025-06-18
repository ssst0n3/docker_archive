#!/usr/bin/env bash
target=$(basename "$0")
case "$target" in
    runc)
        port=2343
        ;;
    ctr)
        port=2345
        ;;
    containerd)
        port=2346
        ;;
    containerd-stress)
        port=2347
        ;;
    containerd-shim-runc-v2)
        port=2348
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
