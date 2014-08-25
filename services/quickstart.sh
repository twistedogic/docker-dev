#!/bin/bash
location=$(pwd)
cd ${location}/worker && docker build -t twistedogic/worker .
cd ${location}/h2o && docker build -t twistedogic/h2o .
cd ${location}/r && docker build -t twistedogic/r .
