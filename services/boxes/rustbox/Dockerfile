FROM devbox:latest as builder

FROM rust:slim
MAINTAINER Jordan Li

ENV PATH=/opt/bin:$PATH
COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt
RUN /root/.setup
ADD vimrc.custom /root/.vimrc.custom
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins

RUN vim +PlugInstall +qall
RUN echo "PATH=/usr/local/cargo/bin:$PATH" >> $HOME/.bashrc
RUN rustup component add rustfmt
WORKDIR /root/workspace/

EXPOSE 3000 8080
