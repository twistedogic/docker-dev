FROM twistedogic/devbox:latest
MAINTAINER Jordan Li

ENV GOLANG_VERSION 1.11
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

ADD vimrc.custom $HOME/.vimrc.custom

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz
RUN echo "export GOPATH=$GOPATH" >> /root/.bashrc
RUN echo "export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH" >> /root/.bashrc
RUN go get github.com/klauspost/asmfmt/cmd/asmfmt
RUN go get github.com/derekparker/delve/cmd/dlv
RUN go get github.com/kisielk/errcheck
RUN go get github.com/davidrjenni/reftools/cmd/fillstruct
RUN go get github.com/nsf/gocode
RUN go get github.com/rogpeppe/godef
RUN go get github.com/zmb3/gogetdoc
RUN go get golang.org/x/tools/cmd/goimports
RUN go get github.com/golang/lint/golint
RUN go get github.com/alecthomas/gometalinter
RUN go get github.com/fatih/gomodifytags
RUN go get golang.org/x/tools/cmd/gorename
RUN go get github.com/jstemmer/gotags
RUN go get golang.org/x/tools/cmd/guru
RUN go get github.com/josharian/impl
RUN go get github.com/dominikh/go-tools/cmd/keyify
RUN go get github.com/fatih/motion
RUN vim +PlugInstall +qall
