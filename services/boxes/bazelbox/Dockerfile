ARG BAZEL_VERSION=3.5.0
ARG BASE_IMAGE=l.gcr.io/google/bazel:${BAZEL_VERSION}

FROM devbox:latest AS builder
FROM $BASE_IMAGE
MAINTAINER Jordan Li

ARG GOLANG_VERSION=1.13.5

COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt

ADD https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz /tmp/go.tgz
RUN tar -C /usr/local -xzf /tmp/go.tgz && rm /tmp/go.tgz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/opt/bin:$PATH
RUN go version

RUN /root/.setup 
ADD vimrc.custom /root/.vimrc.custom
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins
RUN vim +PlugInstall +qall

ENTRYPOINT /opt/bin/tmux
WORKDIR /root/workspace/

EXPOSE 3000 8080
