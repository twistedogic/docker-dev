FROM devbox:latest as builder

FROM elixir:slim
MAINTAINER Jordan Li

COPY --from=builder /root/.setup /root/.setup
RUN /root/.setup
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins

RUN vim +PlugInstall +qall
EXPOSE 3000 8080