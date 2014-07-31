FROM twistedogic/mesos-master
MAINTAINER Jordan Li

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /
RUN apt-get update -y

RUN (cd /tmp && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.1.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && mv elasticsearch-* /opt/elasticsearch)
RUN rm -rf /tmp/*

RUN (cd /tmp && wget --no-check-certificate https://github.com/elasticsearch/kibana/archive/v3.0.0milestone2.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && cd kibana-* && cp -rf ./* /usr/share/nginx/html/)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD kibana.sh /usr/local/bin/kibana
RUN chmod +x /usr/local/bin/kibana
RUN rm -rf /tmp/*

RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate
ADD ./logstash.sh /usr/local/bin/logstash
RUN chmod +x /usr/local/bin/logstash

RUN echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' > /etc/apt/sources.list.d/r.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y r-base r-base-dev r-base-core

RUN wget http://s3.amazonaws.com/h2o-release/h2o/rel-kolmogorov/3/h2o-2.4.4.3.zip -O /opt/h2o-2.4.4.3.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.4.4.3.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#ADD setup.sh /usr/bin/setandgo
#RUN chmod +x /usr/bin/setandgo
RUN mkdir -p /etc/consul.d
EXPOSE 5050 22 2181 2888 3888 9000 8080 8081 8082 8300 8500
CMD ["/usr/bin/supervisord"]
