#!/usr/bin/env bash
target=$(basename "$0")
case "$target" in
    runc)
        port=2341
        ;;
    dockerd)
        port=2343
        ;;
    docker)
        port=2344
        ;;
    containerd)
        port=2345
        ;;
    containerd-shim)
        port=2346
        ;;
    containerd-shim-runc-v1)
        port=2347
        ;;
    containerd-shim-runc-v2)
        port=2348
        ;;
    ctr)
        port=2349
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
