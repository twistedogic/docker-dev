#!/bin/bash

node node_modules/.bin/ql.io.app --cluster --tables /data/tables/ --routes /data/routes/ --config /data/config/dev.json $@
