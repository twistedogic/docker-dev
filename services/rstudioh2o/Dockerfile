FROM angelrr7702/rstudio

MAINTAINER twistedogic

RUN apt-get update && apt-get install -y wget curl unzip git

RUN apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update && apt-get install -y -q nodejs

RUN wget http://s3.amazonaws.com/h2o-release/h2o/rel-kolmogorov/3/h2o-2.4.4.3.zip -O /opt/h2o-2.4.4.3.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.4.4.3.zip
ADD ./run.sh /usr/bin/h2o
RUN chmod +x /usr/bin/h2o

RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN npm install -g shiny-server
RUN cd /home/ && npm install codebox@0.7.6
ADD package.json /home/node_modules/codebox/node_modules/connect-gzip-static/package.json
RUN cd /home/node_modules/codebox/node_modules/connect-gzip-static/ && npm install
RUN mkdir -p /home/myworkspace


ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 54321 58682 8787 8000 22 7777
CMD ["/usr/bin/supervisord"]
