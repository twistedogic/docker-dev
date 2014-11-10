KID=$(docker run -d -p 9300:9300 -p 9200:9200 -p 514:514 -p 80:80 twistedogic/kibana)
KIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${KID})
docker run -d -p 8000:8000 -v=/var/run/docker.sock:/tmp/docker.sock progrium/logspout syslog://${KIP}:514
