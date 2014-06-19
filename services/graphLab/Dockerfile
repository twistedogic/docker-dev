FROM worker
MAINTAINER twistedogic
RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc g++ build-essential libopenmpi-dev openmpi-bin cmake zlib1g-dev git 

RUN git clone https://github.com/graphlab-code/graphlab.git /graphlab
RUN cd /graphlab && ./configure

RUN cd /graphlab/release && make -j 4
RUN cd /graphlab/release && make install

RUN pip install GraphLab-Create
RUN pip install ipython
RUN pip install pyzmq tornado jinja2
RUN easy_install readline
RUN pip install matplotlib
RUN pip install networkx
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8888
EXPOSE 22
CMD ["/usr/bin/supervisord"]