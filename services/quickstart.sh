#!/bin/bash
location=$(pwd)
cd ${location}/worker && docker build -t twistedogic/worker .
cd ${location}/dashboard && docker build -t twistedogic/dashboard .
cd ${location}/h2o && docker build -t twistedogic/h2o .
