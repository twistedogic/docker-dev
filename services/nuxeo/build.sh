#/bin/bash
location=$(pwd)

cd ${location}/nuxeobase && docker build -t nuxeobase .
cd ${location}/nuxeo && docker build -t nuxeo .
cd ${location}/graphite && docker build -t graphite .
cd ${location}/diamond && docker build -t diamond .
