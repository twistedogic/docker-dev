if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi
localip=$(ip -o -4 addr list $1 | grep global | awk '{print $4}' | cut -d/ -f1)
docker run --net=host -d --name=zookeeper jplock/zookeeper
sleep 10
docker run -d \
    --name=mesos_master \
    --privileged \
    --net=host \
    mesosphere/mesos-master:0.21.1-1.1.ubuntu1404 \
    --ip=${localip} \
    --zk=zk://${localip}:2181/mesos \
    --work_dir=/var/lib/mesos/master \
    --quorum=1
sleep 10
docker run -d \
    --name=mesos_slave \
    --net=host \
    --privileged \
    -v /sys:/sys \
    -v /usr/bin/docker:/usr/bin/docker:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /lib64/libdevmapper.so.1.02:/lib/libdevmapper.so.1.02:ro \
    mesosphere/mesos-slave:0.21.1-1.1.ubuntu1404 \
    --ip=${localip} \
    --containerizers=docker \
    --master=zk://${localip}:2181/mesos \
    --work_dir=/var/lib/mesos/slave \
    --log_dir=/var/log/mesos/slave
docker run -d \
    --name chronos \
    -p 8081:8081 \
    twistedogic/chronos:latest \
    --master zk://${localip}:2181/mesos \
    --zk_hosts ${localip}:2181 \
    --http_port 8081
docker run \
    --name marathon \
    -e LIBPROCESS_PORT=9090 \
    -p 8080:8080 \
    -p 9090:9090 \
    mesosphere/marathon:v0.7.6 \
    --master zk://${localip}:2181/mesos \
    --zk zk://${localip}:2181/marathon \
    --checkpoint \
    --task_launch_timeout 300000