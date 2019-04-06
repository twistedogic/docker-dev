FROM devbox:latest as builder

FROM nodebox:latest
MAINTAINER Jordan Li <twistedogic@gmail.com>

RUN npm install -g yarn
RUN yarn global add bs-platform reason-cli@3.1.0-linux ocaml-language-server create-react-app reason-scripts

ADD vimrc.custom /root/.vimrc.custom
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins

RUN vim +PlugInstall +qall

EXPOSE 3000 8080