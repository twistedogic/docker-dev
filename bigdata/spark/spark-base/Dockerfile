FROM twistedogic/hadoop-base
MAINTAINER Jordan Li <twistedogic@gmail.com>
ENV SCALA_VERSION 2.10.3
ENV SPARK_VERSION 1.3.1
ENV SCALA_HOME /opt/scala-$SCALA_VERSION
ENV SPARK_HOME /opt/spark-$SPARK_VERSION
ENV PATH $SPARK_HOME:$SCALA_HOME/bin:$PATH
ENV SERF_HOME /root/serf
RUN mkdir $SERF_HOME && mkdir $SERF_HOME/bin && mkdir $SERF_HOME/etc
WORKDIR /

RUN apt-get update && apt-get install wget unzip -y
# Install Scala
RUN wget http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.tgz -P /
RUN (cd / && gunzip < scala-$SCALA_VERSION.tgz)|(cd /opt && tar -xvf -)
RUN rm /scala-$SCALA_VERSION.tgz

# Install Spark
RUN wget http://apache.01link.hk/spark/spark-1.3.1/spark-1.3.1-bin-hadoop2.6.tgz -P /
RUN (cd / && gunzip < spark-1.3.1-bin-hadoop2.6.tgz)|(cd /opt && tar -xvf -)
RUN (ln -s /opt/spark-1.3.1-bin-hadoop2.6 /opt/spark-$SPARK_VERSION && rm /spark-1.3.1-bin-hadoop2.6.tgz)

# Install Serf
RUN wget https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip -P /tmp
RUN unzip /tmp/0.6.4_linux_amd64.zip -d $SERF_HOME/bin && rm -f /tmp/0.6.4_linux_amd64.zip

COPY serf_init.sh $SERF_HOME/bin/serf_init.sh
RUN chmod +x $SERF_HOME/bin/*

#ADD files /root/spark_files
