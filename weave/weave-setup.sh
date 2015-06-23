curl -L git.io/weave -o /usr/local/bin/weave
chmod a+x /usr/local/bin/weave
curl -L https://github.com/weaveworks/scope/releases/download/latest_release/scope -o /usr/local/bin/scope
chmod a+x /usr/local/bin/scope
HOST_ID="$1"
BRIDGE_CIDR="192.168.0.${HOST_ID}/16"
NETWORK_CIDR="192.168.${HOST_ID}.0/24"
echo "# /etc/sysconfig/docker-network
# Modify these options if you want to change the way the docker daemon runs
DOCKER_NETWORK_OPTIONS=\"--bridge=weave --fixed-cidr=${NETWORK_CIDR}\"" | tee /etc/sysconfig/docker-network > /dev/null
echo "BRIDGE_CIDR=${BRIDGE_CIDR}
PEERS=$2" | tee /etc/sysconfig/weave > /dev/null 
weave create-bridge
weave expose ${BRIDGE_CIDR}
systemctl stop docker.service
systemctl start docker.service
