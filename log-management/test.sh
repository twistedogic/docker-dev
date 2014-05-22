docker run -d -p 9200:9200 -p 9300:9300 arcus/elasticsearch
docker run -d -p 514:514 -e ES_HOST=192.168.99.102 -e ES_PORT=9300 arcus/logstash
docker run -d -p 80:80 -e ES_HOST=192.168.99.102 -e ES_PORT=9200 arcus/kibana
##echo "*.* @@<DOCKER_HOST_IP>:<LOGSTASH_CONTAINER_PORT>" >> /etc/rsyslog.d/50-default.conf
