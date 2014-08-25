## start with the latest ubuntu
FROM twistedogic/rstudio

## That's me
MAINTAINER twistedogic

## Remain current
RUN apt-get update -qq
RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get install libxml2-dev -y
RUN apt-get install libglpk-dev -y

RUN R -e "install.packages(c('devtools','quantmod','Quandl','fTrading','TTR','robustbase','quadprog','Rglpk'),repos='http://cran.rstudio.com/')"
RUN R --slave -e "install.packages(c('sn','ecodist','energy','mvnormtest'),repos='http://cran.rstudio.com/')"
RUN R --slave -e "install.packages('http://cran.r-project.org/src/contrib/Archive/fCopulae/fCopulae_3000.79.tar.gz',repos=NULL,type='source')"
RUN R --slave -e "install.packages('http://cran.at.r-project.org/src/contrib/Archive/fAssets/fAssets_3003.81.tar.gz',repos=NULL,type='source')"
RUN R --slave -e "install.packages('http://cran.r-project.org/src/contrib/Archive/fPortfolio/fPortfolio_2130.80.tar.gz',repos=NULL,type='source')"

## To have a container run multiple & persistent tasks, we use the very simple supervisord as recommended in Docker documentation.
CMD ["/usr/bin/supervisord"]


