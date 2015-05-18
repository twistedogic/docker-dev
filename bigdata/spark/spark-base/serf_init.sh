#!/bin/bash

SERF_BIN=$SERF_HOME/bin/serf
SERF_CONFIG_DIR=$SERF_HOME/etc
SERF_LOG_FILE=/var/log/serf.log

# if SERF_JOIN_IP env variable set generate a config json for serf
[[ -n $SERF_JOIN_IP ]] && cat > $SERF_CONFIG_DIR/join.json <<EOF
{
  "retry_join" : ["$SERF_JOIN_IP"],
  "retry_interval" : "5s"
}
EOF

$SERF_BIN agent -config-dir $SERF_CONFIG_DIR $@ | tee -a $SERF_LOG_FILE
