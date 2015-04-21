#!/bin/bash
yum remove docker -y
rm -rf /var/lib/docker
yum install device-mapper-event-libs -y
yum install docker -y
