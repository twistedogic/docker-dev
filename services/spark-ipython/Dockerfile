FROM logbase/spark-ipython-scipy
MAINTAINER Jordan Li <twistedogic@gmail.com>
RUN apt-get update -y && apt-get install wget unzip python-mysqldb -y
RUN pip2 install zipline
RUN pip3 install zipline
RUN pip2 install redis
RUN pip3 install redis
RUN apt-get install -y libopenblas-dev liblapack-dev gfortran && \
  wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
  tar -xvzf ta-lib-0.4.0-src.tar.gz && \
  cd ta-lib/ && \
  ./configure --prefix=/usr && \
  make && \
  make install
# Python wrapper
RUN git clone https://github.com/mrjbq7/ta-lib.git ta-lib-git && cd ta-lib-git && python2 setup.py install && python3 setup.py install

