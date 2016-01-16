FROM twistedogic/covim:latest
MAINTAINER Jordan Li
ENV SCALA_VERSION 2.10.3
ENV SPARK_VERSION 1.4.1
ENV SPARK_TGZ spark-1.4.1-bin-hadoop2.6
ENV SPARK_DOWNLOAD_URL http://d3kbcqa49mib13.cloudfront.net/spark-1.4.1-bin-hadoop2.6.tgz
ENV SCALA_HOME /opt/scala-$SCALA_VERSION
ENV SPARK_HOME /opt/spark-$SPARK_VERSION
ENV PATH $SPARK_HOME:$SCALA_HOME/bin:$PATH
ENV GOLANG_VERSION 1.5.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV SBT_VERSION 0.13.9
ENV SBT_HOME /usr/local/sbt
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update \
  && apt-get install -y oracle-java8-installer libc6-dev \
  && apt-get install -y oracle-java8-set-default python2.7 \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/cache/oracle-jdk7-installer \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" -o sbt.tgz \
  && tar -C /usr/local -xzf sbt.tgz \
  && rm sbt.tgz

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN apt-get update && \
  apt-get install wget unzip ca-certificates openjdk-7-jre python2.7 -y && \
  apt-get clean autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
# Install Scala
RUN wget http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.tgz -P /
RUN (cd / && gunzip < scala-$SCALA_VERSION.tgz)|(cd /opt && tar -xvf -)
RUN rm /scala-$SCALA_VERSION.tgz

# Install Spark
RUN wget "${SPARK_DOWNLOAD_URL}" -P /
RUN (cd / && gunzip < ${SPARK_TGZ}.tgz)|(cd /opt && tar -xvf -)
RUN (ln -s /opt/${SPARK_TGZ} /opt/spark-$SPARK_VERSION && rm /${SPARK_TGZ}.tgz)
ADD tmux.conf /root/.tmux.conf
ADD vimrc /root/.vimrc
ADD vimrc.bundles /root/.vimrc.bundles

RUN sh ~/vimsetup
