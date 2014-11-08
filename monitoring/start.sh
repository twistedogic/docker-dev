docker run --name influxdb \
  -d \
  -p 8083:8083 \
  -p 8086:8086 \
  --expose 8090 \
  --expose 8099 \
  -e PRE_CREATE_DB="cadvisor"  \
  tutum/influxdb

docker run --name cadvisor \
  -d \
  -v /var/run:/var/run:rw \
  -v /sys:/sys:ro \
  -v /var/lib/docker/:/var/lib/docker:ro \
  -p 8080:8080 \
  google/cadvisor:latest \
  --storage_driver=influxdb \
  --storage_driver_host=10.1.42.1:8086 \
  --log_dir=/

docker run --name grafana \
  -d \
  -p 8088:80 \
  -e INFLUXDB_HOST=10.1.42.1 \
  -e INFLUXDB_PORT=8086 \
  -e INFLUXDB_NAME=cadvisor \
  -e INFLUXDB_USER=root \
  -e INFLUXDB_PASS=root \
  tutum/grafana

