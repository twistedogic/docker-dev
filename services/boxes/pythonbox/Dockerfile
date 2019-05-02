FROM devbox:latest as builder

FROM python:3.7-slim
MAINTAINER Jordan Li

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

COPY --from=builder /root/.setup /root/.setup
RUN /root/.setup

RUN vim +PlugInstall +qall
WORKDIR /root/workspace/

EXPOSE 3000 8080
