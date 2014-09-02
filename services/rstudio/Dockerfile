## start with the latest ubuntu
FROM dustin/r-studio-server

## That's me
MAINTAINER twistedogic

RUN echo 'root:passw0rd' | chpasswd

RUN apt-get -y update
RUN apt-get install -y -q python-software-properties software-properties-common
#RUN add-apt-repository -y ppa:gophers/go
# RUN add-apt-repository -y ppa:chris-lea/node.js
# RUN add-apt-repository -y ppa:webupd8team/java
# RUN add-apt-repository -y ppa:nginx/stable
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
# RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
# RUN apt-get -y update

#SHIMS
ENV DEBIAN_FRONTEND noninteractive

# EDITORS
RUN apt-get install -y -q vim
RUN apt-get install -y -q nano

# TOOLS
RUN apt-get install -y -q curl git make wget unzip

# BUILD
RUN apt-get install -y -q build-essential g++

# LANGS

## GO
RUN apt-get install -y -q golang

## RUBY
RUN apt-get install -y -q ruby

## PHP
RUN apt-get install -y -q php5
RUN apt-get install -y -q php-pear

## ERLANG
RUN apt-get install -y -q erlang

## PYTHON
RUN apt-get install -y -q python-software-properties
RUN apt-get install -y -q python
RUN apt-get install -y -q python-dev
RUN apt-get install -y -q python-distribute
RUN apt-get install -y -q python-pip
RUN pip --no-input --exists-action=w install --upgrade pip

# # # JAVA
# # # Broken
RUN apt-get install -y openjdk-7-jre-headless

# LIB
RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get install libxml2-dev -y
RUN apt-get install libglpk-dev -y

ENV DEBIAN_FRONTEND dialog

CMD ["/usr/local/bin/start"] 