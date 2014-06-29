#!/bin/sh

mkdir -p /usr/local/zookeeper
mkdir -p /var/zookeeper
mkdir -p /usr/local/zeromq
mkdir -p /usr/local/pyzmq
mkdir -p /usr/local/jzmq
mkdir -p /usr/local/storm
mkdir -p /var/log/storm
mkdir ~/.storm
mkdir -p /var/storm/tmp

cd /
wget http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
tar -xvzf zookeeper-3.4.6.tar.gz
rm zookeeper-3.4.6.tar.gz
cp -r zookeeper-3.4.6/* /usr/local/zookeeper
rm -rf zookeeper-3.4.6

cd /
wget http://download.zeromq.org/zeromq-3.2.4.tar.gz
tar -xvzf zeromq-3.2.4.tar.gz
rm zeromq-3.2.4.tar.gz
cp -r zeromq-3.2.4/* /usr/local/zeromq
rm -rf zeromq-3.2.4
cd /usr/local/zeromq
/usr/local/zeromq/configure
make
make install
ldconfig

cd /
wget https://github.com/halfaleague/jzmq/archive/master.tar.gz
tar -xvzf master.tar.gz
rm master.tar.gz
cp -r jzmq-master/* /usr/local/jzmq
rm -rf jzmq-master
cd /usr/local/jzmq
/bin/sh /usr/local/jzmq/autogen.sh
/usr/local/jzmq/configure
make
make install

cd /
wget http://mirror.ox.ac.uk/sites/rsync.apache.org/incubator/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.zip
unzip apache-storm-0.9.1-incubating.zip
rm apache-storm-0.9.1-incubating.zip
cp -r apache-storm-0.9.1-incubating/* /usr/local/storm
rm -rf apache-storm-0.9.1-incubating.zip
cd /usr/local/storm/bin
chmod +x storm