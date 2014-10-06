FROM twistedogic/rstudio
MAINTAINER twistedogic

RUN apt-get update
RUN wget http://h2o-release.s3.amazonaws.com/h2o/rel-lambert/5/h2o-2.6.1.5.zip -O /opt/h2o-2.6.1.5.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.6.1.5.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 54321 58682 8787 8000 22 7777
CMD ["/usr/bin/supervisord"]
