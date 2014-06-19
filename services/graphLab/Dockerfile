FROM worker
MAINTAINER twistedogic
RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc g++ build-essential libopenmpi-dev openmpi-bin default-jdk cmake zlib1g-dev git 

RUN git clone https://github.com/graphlab-code/graphlab.git /graphlab
RUN cd /graphlab && ./configure
RUN pip install GraphLab-Create

RUN cd /graphlab/release && make -j4
RUN cd /graphlab/release && make install

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6379
EXPOSE 9200
EXPOSE 9300
EXPOSE 80
EXPOSE 22
CMD ["/usr/bin/supervisord"]
