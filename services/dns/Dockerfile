FROM google/debian:wheezy
MAINTAINER Jordan Li
RUN apt-get update

RUN apt-get install -y dnsmasq-base procps

RUN echo "user=root" > /etc/dnsmasq.conf
RUN echo "addn-hosts=/etc/althosts" >> /etc/dnsmasq.conf
RUN echo "listen-address=0.0.0.0" >> /etc/dnsmasq.conf
RUN echo "resolv-file=/etc/resolv.dnsmasq.conf" >> /etc/dnsmasq.conf
RUN echo "bind-interfaces" >> /etc/dnsmasq.conf
RUN echo "expand-hosts" >> /etc/dnsmasq.conf
RUN echo "port=53" >> /etc/dnsmasq.conf
RUN echo "log-queries" >> /etc/dnsmasq.conf
RUN echo "resolv-file=/etc/resolv.dnsmasq.conf" >> /etc/dnsmasq.conf

RUN echo "nameserver 8.8.8.8" > /etc/resolv.dnsmasq.conf

CMD dnsmasq

