## start with the latest ubuntu
FROM twistedogic/worker

## That's me
MAINTAINER twistedogic

## Remain current
RUN apt-get update -qq
RUN apt-get dist-upgrade -y

## get tool
RUN apt-get install -y software-properties-common

## Add CRAN repo to get current R
RUN add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)/"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

## Update again
RUN apt-get update -qq
RUN apt-get dist-upgrade -y

RUN apt-get install -y --no-install-recommends r-base r-base-dev r-recommended littler
RUN ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r

## Install a few more things that are useful
RUN apt-get install -y --no-install-recommends vim-tiny

## User-configurable environmental variables
ENV DEBIAN-FRONTEND noninteractive
ENV USER rstudio
ENV EMAIL rstudio@example.com
ENV PASSWORD rstudio


## RStudio server
####  Get Rstudio dependencies. Combining calls helps keep the layer count below 42
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe" >> /etc/apt/sources.list
RUN (echo "deb http://cran.mtu.edu/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9)
RUN apt-get update -q && apt-get dist-upgrade -yq && apt-get install -y -q gdebi-core libapparmor1 supervisor sudo libcurl4-openssl-dev wget git && update-locale

#### And now we're ready for rstudio server
RUN wget http://download2.rstudio.org/rstudio-server-0.98.994-amd64.deb && gdebi -n rstudio-server-0.98.994-amd64.deb && rm rstudio-server-*-amd64.deb
RUN useradd -m $USER && echo "$USER:$PASSWORD" | chpasswd

## These shell scripts are executed by supervisord when it is run by CMD
## They use environmental variables given at runtime to configure the rstudio and git users
## They cannot be run using a RUN command because that would merely bake the defaults into the binary image.
ADD userconf.sh /usr/bin/userconf.sh
RUN chmod a+x /usr/bin/userconf.sh


## Configure persistent daemon serving RStudio-server on (container) port 8787
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8787

## To have a container run multiple & persistent tasks, we use the very simple supervisord as recommended in Docker documentation.
CMD ["/usr/bin/supervisord"]


