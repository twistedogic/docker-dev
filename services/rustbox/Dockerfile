FROM twistedogic/devbox:latest
MAINTAINER Jordan Li

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ADD vimrc.custom /root/.vimrc.custom
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins

RUN vim +PlugInstall +qall
