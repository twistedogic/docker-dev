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

RUN (echo "deb http://cran.mtu.edu/bin/linux/ubuntu saucy/" >> /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9)
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install -y -q r-base r-base-dev gdebi-core libapparmor1 supervisor sudo libcurl4-openssl-dev
RUN (wget http://download2.rstudio.org/rstudio-server-0.98.939-amd64.deb && gdebi -n rstudio-server-0.98.939-amd64.deb)
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)

RUN apt-get install -y unzip
RUN wget http://s3.amazonaws.com/h2o-release/h2o/rel-knuth/11/h2o-2.4.3.11.zip -O /opt/h2o-2.4.3.11.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.4.3.11.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o
RUN sudo su - \
    -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""
RUN (wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.1.0.10000-amd64.deb && gdebi shiny-server-1.1.0.10000-amd64.deb)

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#ADD setup.sh /usr/bin/setandgo
#RUN chmod +x /usr/bin/setandgo
RUN mkdir -p /etc/consul.d
EXPOSE 5050 22 2181 2888 3888 9000 8080 8081 8082 8300 8500
CMD ["/usr/bin/supervisord"]
