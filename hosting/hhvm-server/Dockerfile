FROM ubuntu:trusty
MAINTAINER twistedogic

# install add-apt-repository
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties

# we'll need wget to fetch the key...
RUN apt-get install -y wget
RUN add-apt-repository -y ppa:chris-lea/node.js

RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update
RUN apt-get install hhvm curl git make wget supervisor unzip vim build-essential g++ nodejs nginx -y
RUN wget http://getcomposer.org/composer.phar && mv composer.phar /usr/local/bin/composer
RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server ;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true
ADD sshd_config /etc/ssh/sshd_config
RUN cd /home/ && npm install codebox@0.7.6
ADD package.json /home/node_modules/codebox/node_modules/connect-gzip-static/package.json
RUN cd /home/node_modules/codebox/node_modules/connect-gzip-static/ && npm install
RUN mkdir -p /home/myworkspace
RUN sh /usr/share/hhvm/install_fastcgi.sh
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"] 
