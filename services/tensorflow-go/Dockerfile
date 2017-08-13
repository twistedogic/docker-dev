FROM tensorflow/tensorflow:1.2.0
MAINTAINER Jordan Li

ENV GOLANG_VERSION 1.8.3
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOPATH /go
ENV TF_TYPE cpu
ENV TARGET_DIRECTORY /usr/local
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN apt-get update && apt-get install -y git vim

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz
RUN echo "export GOPATH=$GOPATH" >> /root/.bashrc
RUN echo "export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH" >> /root/.bashrc

RUN curl -L "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-${TF_TYPE}-$(go env GOOS)-x86_64-1.2.0.tar.gz" | tar -C $TARGET_DIRECTORY -xz

RUN ldconfig
