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
RUN vim +PlugInstall +qall
 
WORKDIR /root/workspace

EXPOSE 3000 8080
