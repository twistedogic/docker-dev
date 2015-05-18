#!/bin/bash
IP=$(ip -o -4 addr list eth0 | perl -n -e 'if (m{inet\s([\d\.]+)\/\d+\s}xms) { print $1 }')
mesos-master --ip=$IP \
    --zk=zk://$ZK_IP:2181/mesos \
    --work_dir=/var/lib/mesos/master \
    --quorum=1
