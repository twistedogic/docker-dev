FROM google/debian:wheezy
MAINTAINER Jordan Li

ENV NOMAD_VERSION 0.1.2

RUN apt-get update && apt-get install -y wget unzip

RUN wget -qO- -O nomad.zip https://dl.bintray.com/mitchellh/nomad/nomad_${NOMAD_VERSION}_linux_amd64.zip --no-check-certificate && unzip -d /usr/bin/ nomad.zip && rm nomad.zip && chmod +x /usr/bin/nomad

RUN mkdir /etc/nomad.d
RUN chmod a+w /etc/nomad.d
