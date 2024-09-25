#!/bin/bash

# check image exists in registry

REPO="ssst0n3/docker_archive"

check() {
    local tag=$1

    if docker manifest inspect "$tag" 2>&1 | grep -q 'no such manifest'; then
        echo "$tag ❌"
    else
        echo "$tag ✔️"
    fi
}

find . -type f -name ".env" | while read env_file; do
    DIR=$(dirname $env_file)
    echo $DIR
    source "$env_file"
    CTR_TAG=$REPO:ctr_$IMAGE
    DQD_TAG=$REPO:$IMAGE
    check ${CTR_TAG}
    check ${CTR_TAG}_${VERSION}
    check $DQD_TAG
    check ${DQD_TAG}_${VERSION}
done
