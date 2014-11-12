FROM ubuntu:trusty
MAINTAINER twistedogic
RUN apt-get update -y
RUN apt-get install python-software-properties software-properties-common python-mysqldb crudini -y
RUN add-apt-repository cloud-archive:juno
RUN apt-get update -y && apt-get dist-upgrade -y
