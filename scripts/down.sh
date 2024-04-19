#!/usr/bin/env bash

THE_LABEL=containers.dev/id=thedevcontainer

ID="$(docker ps --filter=label=containers.dev/id=thedevcontainer --quiet)"
if [ -z "$ID" ]; then
  printf "[INFO] Currently no Dev Container with label \"$THE_LABEL\” is running."
  exit 0
else
  printf "[INFO] Stopping Dev Container with label \"$THE_LABEL\”."
  docker stop "$ID"
  docker remove "$ID"
fi