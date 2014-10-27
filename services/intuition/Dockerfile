FROM hivetech/pyscience
MAINTAINER twistedogic

# Local settings
#RUN apt-get update && \
  #apt-get install -y language-pack-fr wget git-core libssl-dev
#ENV LANGUAGE fr_FR.UTF-8
#ENV LANG fr_FR.UTF-8
#ENV LC_ALL fr_FR.UTF-8
#RUN locale-gen fr_FR.UTF-8 && dpkg-reconfigure locales

RUN git clone https://github.com/intuition-io/intuition.git -b develop --depth 1 && \
  cd /intuition && python setup.py install

# Install modules
RUN git clone https://github.com/intuition-io/insights.git -b develop --depth 1 && \
  apt-get update && apt-get install -y libreadline-dev && \
  cd insights && python setup.py install
# Install R libraries
RUN wget -qO- http://bit.ly/L39jeY | R --no-save
RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server ;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true

RUN apt-get -y update
RUN apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update -y && apt-get install -y -q nodejs supervisor
RUN cd /home/ && npm install codebox@0.7.6
ADD package.json /home/node_modules/codebox/node_modules/connect-gzip-static/package.json
RUN cd /home/node_modules/codebox/node_modules/connect-gzip-static/ && npm install
RUN mkdir -p /home/myworkspace

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD sshd_config /etc/ssh/sshd_config
CMD ["/usr/bin/supervisord"]
