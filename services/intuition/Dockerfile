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

ADD sshd_config /etc/ssh/sshd_config
CMD ["/usr/sbin/sshd -D"]
