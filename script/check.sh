#!/bin/bash

trap 'echo "force kill all process"; kill -- -$$ 2>/dev/null; exit 1' SIGINT

REPO="ssst0n3/docker_archive"

check() {
    local tag="$1"
    local output
    output=$(timeout 10s docker manifest inspect "$tag" 2>&1)
    local exit_code=$?

    if [[ $exit_code -eq 124 ]]; then
        echo "$tag ⌛ TIMEOUT"
        return
    fi

    if [[ $exit_code -eq 0 ]]; then
        echo "$tag ✔️"
    else
        case $output in
            *"no such manifest"* | *"manifest unknown"*)
                echo "$tag ❌ NOT EXISTS" ;;
            *)
                echo "$tag ⚠️ UNKNOWN ERROR: ${output:0:200}" ;;
        esac
    fi
}

while IFS= read -r -d '' env_file; do
    source "$env_file"
    CTR_TAG=$REPO:ctr_$IMAGE
    DQD_TAG=$REPO:$IMAGE
    check ${CTR_TAG}
    check ${CTR_TAG}_${VERSION}
    check $DQD_TAG
    check ${DQD_TAG}_${VERSION}
done < <(find . -type f -name ".env" -print0)

wait

