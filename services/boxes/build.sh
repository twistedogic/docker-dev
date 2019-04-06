#!/bin/bash
docker build -t devbox base/
for dir in *box; do
  docker build -t $dir $dir
done