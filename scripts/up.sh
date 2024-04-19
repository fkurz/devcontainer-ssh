#!/usr/bin/env bash
set -e

docker build \
    --tag devcontainer-base-image:latest \
    --file .devcontainer/devcontainer-base-image/Dockerfile \
    .devcontainer/devcontainer-base-image
devcontainer \
    --workspace-folder . \
    up --id-label=containers.dev/id=thedevcontainer