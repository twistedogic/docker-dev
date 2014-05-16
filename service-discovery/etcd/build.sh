#!/bin/bash
location=$(pwd)
docker build -t etcd-ssh .
echo "build completed!"
