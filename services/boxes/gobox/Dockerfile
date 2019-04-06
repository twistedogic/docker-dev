FROM devbox:latest AS builder

FROM golang:stretch
MAINTAINER Jordan Li

COPY --from=builder /root/.setup /root/.setup
RUN /root/.setup
ADD vimrc.custom /root/.vimrc.plugins

RUN vim +PlugInstall +qall

EXPOSE 3000 8080