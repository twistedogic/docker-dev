#!/bin/bash

docker build -t="twistedogic/storm" storm
docker build -t="twistedogic/storm-nimbus" storm-nimbus
docker build -t="twistedogic/storm-supervisor" storm-supervisor
docker build -t="twistedogic/storm-ui" storm-ui
