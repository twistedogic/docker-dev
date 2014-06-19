FROM worker
MAINTAINER twistedogic
RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y unzip
RUN wget http://s3.amazonaws.com/h2o-release/h2o/rel-knuth/11/h2o-2.4.3.11.zip -O /opt/h2o-2.4.3.11.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.4.3.11.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o
EXPOSE 54321
EXPOSE 58682
CMD ["/usr/bin/h2o"]
