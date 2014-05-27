#!/bin/bash
location=$(pwd)
docker build -t consul .
echo "build completed!"
