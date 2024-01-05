#!/usr/bin/env bash

set -euo pipefail

cache=./docker-build-cache

rm -rf -- "$cache"

for n in first second; do
  printf -- '---- %s run ----\n\n' "$n"

  date > random

  docker buildx \
         create \
         --bootstrap \
         --use

  docker buildx \
        build \
        --cache-to   "type=local,dest=$cache,mode=max" \
        --cache-from "type=local,src=$cache" \
        --load \
        --tag foo \
        --progress plain \
        . || true

  docker buildx rm
done
