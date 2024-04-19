#!/usr/bin/env bash

THE_LABEL='containers.dev/id=thedevcontainer'

printf "\nRunning docker exec on the container with label \"${THE_LABEL}\” and command \”$@\”."

docker ps --filter=label="${THE_LABEL}" --quite | xargs -I{} docker exec {} $@