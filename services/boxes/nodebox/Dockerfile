FROM devbox:latest AS builder

FROM node:10-buster
MAINTAINER Jordan Li

RUN npm install -g create-react-app gatsby-cli

COPY --from=builder /root/.setup /root/.setup
RUN /root/.setup
ADD vimrc.custom /root/.vimrc.custom
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins
WORKDIR /root/workspace/

RUN vim +PlugInstall +qall
