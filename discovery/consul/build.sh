#!/bin/bash
location=$(pwd)
docker build -t twistedogic/consul .
echo "build completed!"
