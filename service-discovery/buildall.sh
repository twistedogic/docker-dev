#!/bin/bash
location=$(pwd)
cd ${location}/worker && docker build -t worker .
cd ${location}/consul && docker build -t consul .
cd ${location}/doozer && docker build -t doozer .
cd ${location}/etcd && docker build -t etcd-ssh .
echo "build completed!"
