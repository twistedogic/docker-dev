# runnable base
FROM ubuntu:trusty

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q python-software-properties software-properties-common
#RUN add-apt-repository -y ppa:gophers/go
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN add-apt-repository -y ppa:webupd8team/java
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
RUN apt-get -y update

#SHIMS
ENV DEBIAN_FRONTEND noninteractive

# EDITORS
RUN apt-get install -y -q vim
RUN apt-get install -y -q nano

# TOOLS
RUN apt-get install -y -q curl git make wget supervisor unzip

# BUILD
RUN apt-get install -y -q build-essential g++

# SERVICES

## MEMCACHED
RUN apt-get install -y -q memcached
#RUN pecl install -y memcache

## COUCHDB
RUN apt-get install -y -q couchdb

## REDIS
RUN apt-get install -y -q redis-server

## MONGO
RUN apt-get install -y -q mongodb-10gen

## POSTGRES
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d
RUN apt-get install -y -q postgresql
RUN apt-get install -y -q postgresql-contrib
RUN rm /usr/sbin/policy-rc.d
RUN apt-get install -y -q pgadmin3

## MAGICK
RUN apt-get install -y -q imagemagick
RUN apt-get install -y -q graphicsmagick
RUN apt-get install -y -q graphicsmagick-libmagick-dev-compat
# #RUN pecl install -y imagick

## APACHE
RUN apt-get install -y -q apache2
RUN apt-get install -y -q libapache2-mod-php5

## MYSQL
RUN apt-get install -y -q mysql-client
RUN apt-get install -y -q mysql-server

## NGINX
RUN apt-get install -y -q nginx

# LANGS

## GO
RUN apt-get install -y -q golang

## RUBY
RUN apt-get install -y -q ruby

## NODE
RUN apt-get install -y -q nodejs

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

# LIBS
RUN apt-get install -y -q libjpeg8-dev
RUN apt-get install -y -q zlib1g-dev
RUN apt-get install -y -q libfreetype6-dev
RUN apt-get install -y -q liblcms1-dev
RUN apt-get install -y -q libwebp-dev
RUN apt-get install -y -q libtiff-dev

# # # JAVA
# # # Broken
RUN apt-get install -y openjdk-7-jre-headless

ENV DEBIAN_FRONTEND dialog

RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server ;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true

ADD sshd_config /etc/ssh/sshd_config
RUN gem install compass 
RUN cd /home/ && npm install codebox@0.7.6
ADD package.json /home/node_modules/codebox/node_modules/connect-gzip-static/package.json
RUN cd /home/node_modules/codebox/node_modules/connect-gzip-static/ && npm install
RUN mkdir -p /home/myworkspace

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"] 
