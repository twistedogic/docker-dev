#!/bin/bash
HOST=$(hostname)
CFG=${CFG:-}
ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9300}
EMBEDDED="false"

if [ "$ES_HOST" = "127.0.0.1" ] ; then
    EMBEDDED="true"
fi

if [ "$CFG" != "" ]; then
    wget $CFG -O /opt/logstash.conf --no-check-certificate
else
    cat << EOF > /opt/logstash.conf
input {
 file {
 type => "${HOST}_log"
 path => ["/var/log/supervisor/**"]
 exclude => ["*.gz", "error.*"]
 discover_interval => 10
 }
}
output {
  stdout { debug => true debug_format => "json"}
  redis {
   host => "$ES_HOST"
   data_type => "list"
   key => "logstash:redis"
  }
}
EOF
fi

java -jar /opt/logstash.jar agent -f /opt/logstash.conf
