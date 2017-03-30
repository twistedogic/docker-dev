FROM twistedogic/devbox:latest
MAINTAINER Jordan Li
RUN curl -SLO "$NODE_DOWNLOAD_URL" \ 
  && tar xf node-$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1 \
  && rm node-$NODE_VERSION-linux-x64.tar.xz
