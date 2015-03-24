#!/bin/bash
LOCAL_IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
pyspark -h $LOCAL_IP --master $1
