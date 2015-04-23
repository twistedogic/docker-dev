#!/bin/bash -x
systemctl stop firewalld.service
systemctl mask firewalld.service
systemctl stop docker.service
systemctl disable docker.service
cp -rf docker.service /etc/systemd/system
yum install bridge-utils policycoreutils-python -y
curl --silent --location --output /usr/sbin/weave https://github.com/zettio/weave/releases/download/latest_release/weave
chmod +x /usr/sbin/weave
semanage fcontext -a -t unconfined_exec_t -f f /usr/sbin/weave
restorecon /usr/sbin/weave
# $1 .. unique id of the slave (1..254)
HOST_ID="$1"
BRIDGE_CIDR="192.168.0.${HOST_ID}/16"
NETWORK_CIDR="192.168.${HOST_ID}.0/24"
echo "# /etc/sysconfig/docker

# Modify these options if you want to change the way the docker daemon runs 
DOCKER_NETWORK_OPTIONS=--bridge=weave --fixed-cidr=${NETWORK_CIDR}" | tee /etc/sysconfig/docker-network > /dev/null
echo "PEERS=
BRIDGE_CIDR=${BRIDGE_CIDR}" | tee /etc/sysconfig/weave > /dev/null
weave create-bridge
weave expose ${BRIDGE_CIDR}
systemctl enable docker.socket
systemctl start docker.socket
systemctl enable docker.service
systemctl start docker.service
cp -rf weave.service /etc/systemd/system
systemctl enable weave.service
systemctl start weave.service
