FROM twistedogic/worker
MAINTAINER twistedogic
RUN apt-get update

RUN (echo "deb http://cran.mtu.edu/bin/linux/ubuntu saucy/" >> /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9)
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install -y -q r-base r-base-dev gdebi-core libapparmor1 supervisor sudo libcurl4-openssl-dev
RUN (wget http://download2.rstudio.org/rstudio-server-0.98.939-amd64.deb && gdebi -n rstudio-server-0.98.939-amd64.deb)
RUN rm /rstudio-server-0.98.939-amd64.deb
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)

RUN apt-get install -y unzip
RUN wget http://s3.amazonaws.com/h2o-release/h2o/rel-knuth/11/h2o-2.4.3.11.zip -O /opt/h2o-2.4.3.11.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.4.3.11.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o
RUN sudo su - \
    -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""
RUN (wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.1.0.10000-amd64.deb && gdebi shiny-server-1.1.0.10000-amd64.deb)
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 54321 58682 8787 8000 22 7777
CMD ["/usr/bin/supervisord"]
