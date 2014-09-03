## start with the latest ubuntu
FROM twistedogic/r

## That's me
MAINTAINER twistedogic

RUN apt-get -y update
RUN apt-get install gdebi-core -y
RUN update-locale
RUN (wget http://download2.rstudio.org/rstudio-server-0.98.978-amd64.deb && gdebi -n rstudio-server-0.98.978-amd64.deb)
RUN rm /rstudio-server-0.98.978-amd64.deb
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get install libxml2-dev -y
RUN apt-get install libglpk-dev -y

ENV DEBIAN_FRONTEND dialog

EXPOSE 8787 22 7777
CMD ["/usr/bin/supervisord"] 