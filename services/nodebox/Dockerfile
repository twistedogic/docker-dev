FROM twistedogic/devbox:latest
MAINTAINER Jordan Li

ENV NODE_VERSION v6.9.1
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz
RUN curl -SLO "$NODE_DOWNLOAD_URL" \ 
  && tar xf node-$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1 \
  && rm node-$NODE_VERSION-linux-x64.tar.xz
