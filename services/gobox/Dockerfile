FROM twistedogic/devbox:latest
MAINTAINER Jordan Li

ENV GOLANG_VERSION 1.10.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz
RUN echo "export GOPATH=$GOPATH" >> /root/.bashrc
RUN echo "export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH" >> /root/.bashrc
