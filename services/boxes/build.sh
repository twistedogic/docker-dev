#!/bin/bash
docker build --no-cache -t devbox base/
for dir in *box; do
  docker build --no-cache -t $dir $dir
done
