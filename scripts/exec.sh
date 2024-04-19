#!/usr/bin/env bash

THE_LABEL='containers.dev/id=thedevcontainer'
docker ps --filter=label="$THE_LABEL" --quiet | xargs -I{} docker exec {} $@
