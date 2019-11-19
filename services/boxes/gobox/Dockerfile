FROM devbox:latest AS builder

FROM golang:1.12-stretch
MAINTAINER Jordan Li

ENV PATH=/opt/bin:$PATH
COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt

RUN /root/.setup
ADD vimrc.custom /root/.vimrc.plugins
RUN vim +PlugInstall +qall

RUN echo "export PATH=/usr/local/go/bin:/go/bin:$PATH" >> $HOME/.bashrc

RUN go get github.com/klauspost/asmfmt/cmd/asmfmt && \
    go get github.com/go-delve/delve/cmd/dlv && \
    go get github.com/kisielk/errcheck && \
    go get github.com/davidrjenni/reftools/cmd/fillstruct && \
    go get github.com/mdempsky/gocode && \
    go get github.com/stamblerre/gocode && \
    go get github.com/rogpeppe/godef && \
    go get github.com/zmb3/gogetdoc && \
    go get golang.org/x/tools/cmd/goimports && \
    go get golang.org/x/lint/golint && \
    go get golang.org/x/tools/cmd/gopls && \
    go get github.com/alecthomas/gometalinter && \
    go get github.com/golangci/golangci-lint/cmd/golangci-lint && \
    go get github.com/fatih/gomodifytags && \
    go get golang.org/x/tools/cmd/gorename && \
    go get github.com/jstemmer/gotags && \
    go get golang.org/x/tools/cmd/guru && \
    go get github.com/josharian/impl && \
    go get honnef.co/go/tools/cmd/keyify && \
    go get github.com/fatih/motion && \
    go get github.com/koron/iferr

WORKDIR /root/workspace

EXPOSE 3000 8080
