#!/usr/bin/env bash
set -e

docker build \
    --tag base:latest \
    --file .devcontainer/base/Dockerfile \
    .devcontainer/base
devcontainer \
    --workspace-folder . \
    up --id-label=containers.dev/id=thedevcontainer
