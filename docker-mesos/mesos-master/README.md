Dockerfile for running an [Apache Mesos](http://mesos.apache.org/) master node.

### Configuration

Mesos allows you to set all [configuration
options](http://mesos.apache.org/documentation/latest/configuration/) via
environment variables.  That means that you don't need any additional scripts to
start up a Mesos master node using this Docker image; just pass in `-e` options
to set each configuration option:

    $ docker run -d \
        -e MESOS_LOG_DIR=/var/log \
        -e MESOS_ZK=[zookeeper URL] \
        -p 5050:5050 \
        redjack/mesos-master

Also note the `-p` option, which exposes the default Mesos master TCP port
(5050) on the container host.
