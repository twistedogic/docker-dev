FROM ubuntu:precise
MAINTAINER twistedogic

# environment
ENV DEBIAN_FRONTEND noninteractive
# update, curl
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install curl supervisor nginx-full wget openssh-server && \
    mkdir /var/run/sshd && chmod 700 /var/run/sshd && \
    echo 'root:root' | chpasswd

# fluentd
RUN curl -O http://packages.treasure-data.com/debian/RPM-GPG-KEY-td-agent && apt-key add RPM-GPG-KEY-td-agent && rm RPM-GPG-KEY-td-agent
RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh

RUN /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-elasticsearch --no-ri --no-rdoc -V

ADD td-agent.sh /usr/local/bin/fluentdstart
RUN chmod +x /usr/local/bin/fluentdstart

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./td-agent.conf /etc/td-agent/td-agent.conf.tmp
CMD ["/usr/bin/supervisord"]
