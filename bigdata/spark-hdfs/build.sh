loc=$(pwd)
cd ${loc}/base && docker build -t twistedogic/spark-hdfs-base .
cd ${loc}/master && docker build -t twistedogic/spark-hdfs-master .
cd ${loc}/worker && docker build -t twistedogic/spark-hdfs-worker .
cd ${loc}
