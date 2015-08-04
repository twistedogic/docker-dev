#/bin/bash
IP=$(ip -o -4 addr list eth0 | perl -n -e 'if (m{inet\s([\d\.]+)\/\d+\s}xms) { print $1 }')
echo export SPARK_PUBLIC_DNS=$IP > $SPARK_HOME/conf/spark-env.sh
echo export SPARK_LOCAL_IP=$IP >> $SPARK_HOME/conf/spark-env.sh
echo export SPARK_MASTER_IP=$IP >> $SPARK_HOME/conf/spark-env.sh
$SPARK_HOME/sbin/start-master.sh

tail -F $SPARK_HOME/logs/spark*
