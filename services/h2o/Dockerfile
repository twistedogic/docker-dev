FROM ubuntu:trusty
MAINTAINER twistedogic

RUN apt-get update && apt-get install -y wget unzip curl runit openssh-server && mkdir -p /var/run/sshd && \
    echo 'root:root' |chpasswd

RUN apt-get install -y -q python-software-properties software-properties-common build-essential
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update && apt-get install -y -q nodejs

#Install Oracle Java 7
RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' > /etc/apt/sources.list.d/java.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java7-installer

RUN echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' > /etc/apt/sources.list.d/r.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y r-base 

#RStudio Server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gdebi-core libapparmor1 libcurl4-openssl-dev
RUN wget http://download2.rstudio.org/rstudio-server-0.98.507-amd64.deb && \
    gdebi -n rstudio-server-0.98.507-amd64.deb && \
    rm rstudio-server-*-amd64.deb
RUN useradd -m guest && \
    echo "guest:guest" | chpasswd

RUN wget http://s3.amazonaws.com/h2o-release/h2o/rel-knuth/11/h2o-2.4.3.11.zip -O /opt/h2o-2.4.3.11.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.4.3.11.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o

RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN npm install -g shiny-server
RUN gem install compass 
RUN cd /home/ && npm install codebox@0.7.6
ADD package.json /home/node_modules/codebox/node_modules/connect-gzip-static/package.json
RUN cd /home/node_modules/codebox/node_modules/connect-gzip-static/ && npm install
RUN mkdir -p /home/myworkspace

RUN mkdir -p /var/log/supervisor
ADD sshd_config /etc/ssh/sshd_config
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 54321 58682 8787 8000 22 7777
CMD ["/usr/bin/supervisord"]
