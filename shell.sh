#!/usr/bin/env bash

# run.sh

# run the container in the background
# /data is persisted using a named container

docker run \
    --rm \
    -it \
    --name="hardenapache" \
    hardenapache \
    /bin/bash
