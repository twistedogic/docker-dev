FROM ubuntu:trusty
MAINTAINER Jordan Li <twistedogic@gmail.com>
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FB0ACEBA8887F477
RUN echo "deb https://spotify.github.io/helios-apt helios main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install helios -y
