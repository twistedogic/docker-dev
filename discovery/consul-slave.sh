hostip=$(ip -o -4 addr list eth0 | grep global | awk '{print $4}' | cut -d/ -f1)
docker run -d -h node1 -v /consul-data:/data \
    -p ${hostip}:8300:8300 \
    -p ${hostip}:8301:8301 \
    -p ${hostip}:8301:8301/udp \
    -p ${hostip}:8302:8302 \
    -p ${hostip}:8302:8302/udp \
    -p ${hostip}:8400:8400 \
    -p ${hostip}:8500:8500 \
    -p 172.17.42.1:53:53/udp \
    progrium/consul -server -advertise ${hostip} -join <target-IP>
