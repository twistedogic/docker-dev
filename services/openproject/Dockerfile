#-- copyright
# OpenProject-docker is a set-up script for OpenProject using the
# 'Apache 2.0' licensed docker container engine. See
# http://docker.io and https://github.com/dotcloud/docker for details
#
# OpenProject is a project management system.
# Copyright (C) 2013 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT.md for more details.
#++

FROM stackbrew/ubuntu:13.10

MAINTAINER twistedogic
ENV DEBIAN_FRONTEND noninteractive

# expose rails server port
EXPOSE 8080
# export ssh port; user is openproject; password will be generated and is dumped to stdout during the build
EXPOSE 22

#
# Install ruby and its dependencies
#
# RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe" > /etc/apt/sources.list
RUN apt-get update -q
RUN locale-gen en_US en_US.UTF-8
RUN apt-get install -y --force-yes build-essential curl git zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev libxslt1-dev libmysqlclient-dev libpq-dev libsqlite3-dev libyaml-0-2 libmagickwand-dev libmagickcore-dev libmagickcore5-extra libgraphviz-dev libgvc5 ruby-dev

# Install utilities
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
# Add HTTPS support for APT. Passengers APT repository is stored on an HTTPS server.
RUN apt-get install -q -y --force-yes apt-transport-https ca-certificates
RUN echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger saucy main' > /etc/apt/sources.list.d/passenger.list
RUN chown root: /etc/apt/sources.list.d/passenger.list
RUN chmod 600 /etc/apt/sources.list.d/passenger.list
RUN apt-get update -q
RUN apt-get install -q -y --force-yes memcached subversion vim wget python-setuptools openssh-server sudo pwgen libcurl4-openssl-dev passenger
RUN easy_install supervisor
RUN mkdir /var/log/supervisor/

# see: http://flnkr.com/2013/12/creating-a-docker-ubuntu-13-10-image-with-openssh/
RUN mkdir /var/run/sshd
RUN /usr/sbin/sshd
RUN sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" > /etc/default/local

#
# Install MySQL
#
# RUN apt-get -y --force-yes -q install postgresql postgresql-client postgresql-contrib
RUN apt-get install -y --force-yes -q mysql-client mysql-server

RUN apt-get clean

#
# Setup OpenProject
#
ENV CONFIGURE_OPTS --disable-install-doc
ADD ./files/Gemfile.local /Gemfile.local
ADD ./files/Gemfile.plugins /Gemfile.plugins
ADD ./files/setup_system.sh /setup_system.sh
RUN /bin/bash /setup_system.sh
RUN rm /setup_system.sh
ENV PATH /home/openproject/.rbenv/bin:$PATH
ADD ./files/passenger-standalone.json /home/openproject/openproject/passenger-standalone.json
ADD ./files/start_openproject.sh /home/openproject/start_openproject.sh
ADD ./files/start_openproject_worker.sh /home/openproject/start_openproject_worker.sh

#
# And, finally, launch supervisord in foreground mode.
#
ADD ./files/supervisord.conf /etc/supervisord.conf
ENTRYPOINT ["supervisord", "-n"]
RUN echo "INFO: openproject ssh password: `cat /root/openproject-root-pw.txt`"
