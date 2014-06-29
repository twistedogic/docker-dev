#!/bin/bash
S1=$(docker run --link nimbus:nimbus --dns=172.17.42.1 --dns=8.8.8.8 -d twistedogic/storm-supervisor)
