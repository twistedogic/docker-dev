FROM ubuntu:trusty
MAINTAINER Jordan Li
RUN apt-get update && apt-get install -y expat libexpat1-dev git make build-essential g++ curl python python-dev python-pip python-virtualenv
RUN curl http://nodejs.org/dist/v0.8.15/node-v0.8.15.tar.gz -o node.tar.gz
 
# Install node.js
RUN tar xvfz node.tar.gz
RUN cd node*;./configure; make; make install
 
# Create /usr/local/lib/node_modules and make it writable
RUN mkdir -p /usr/local/lib/node_modules
RUN chmod go+rwx /usr/local/lib/node_modules
RUN git clone git://github.com/ql-io/ql.io.git
RUN cd /ql.io && make install
RUN git clone git://github.com/ql-io/ql.io-site.git
RUN cd ql.io-site && make install
RUN git clone git://github.com/ql-io/ql.io-template.git
RUN cd ql.io-template && make install
WORKDIR /ql.io-template
CMD ["bin/start.sh"]
