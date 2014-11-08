FROM ubuntu:trusty
MAINTAINER twistedogic
RUN apt-get update
RUN apt-get -y install fuse || true
RUN rm -rf /var/lib/dpkg/info/fuse.postinst
RUN apt-get -y install fuse
RUN apt-get install -y openjdk-7-jre nginx-full supervisor wget

# Define working directory.

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz && \
  tar xvzf elasticsearch-1.3.2.tar.gz && \
  rm -f elasticsearch-1.3.2.tar.gz && \
  mv /tmp/elasticsearch-1.3.2 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD ./elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

RUN (cd /tmp && wget --no-check-certificate https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && cd kibana-* && cp -rf ./* /usr/share/nginx/html/)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm -rf /tmp/*

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9200
EXPOSE 9300
EXPOSE 80
CMD ["/usr/bin/supervisord"]
