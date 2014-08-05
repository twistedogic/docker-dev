FROM ubuntu:trusty
MAINTAINER twistedogic

RUN apt-get update

RUN echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' > /etc/apt/sources.list.d/r.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y r-base r-base-dev r-base-core

RUN wget http://s3.amazonaws.com/h2o-release/h2o/rel-kolmogorov/3/h2o-2.4.4.3.zip -O /opt/h2o-2.4.4.3.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.4.4.3.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o

RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN npm install -g shiny-server

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 54321 58682 8787 8000 22 7777
CMD ["/usr/bin/supervisord"]
