FROM devbox:latest as builder
FROM node:13.5-buster-slim as nodebase

FROM rust:1.40-slim-buster
MAINTAINER Jordan Li

ENV PATH=/opt/bin:$PATH
COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt
COPY --from=nodebase /usr/local /usr/local
RUN /root/.setup
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins

RUN vim +PlugInstall +qall
RUN echo "PATH=/usr/local/cargo/bin:$PATH" >> $HOME/.bashrc
WORKDIR /root/workspace/

EXPOSE 3000 8080
