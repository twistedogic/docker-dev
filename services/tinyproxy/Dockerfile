# Tinyproxy (https://banu.com/tinyproxy/)

FROM ubuntu:precise
MAINTAINER Jordan 

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
        apt-get update && \
        apt-get upgrade

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
# Install Tinyproxy
RUN apt-get -y install tinyproxy

# Configure Tinyproxy
# This allows allows all connections.
RUN sed -i -e"s/^Allow /#Allow /" /etc/tinyproxy.conf

USER nobody
EXPOSE 8888
ENTRYPOINT ["/usr/sbin/tinyproxy", "-d"]
