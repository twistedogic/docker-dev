FROM devbox:latest as builder

FROM python:3.7-slim
MAINTAINER Jordan Li

ENV LC_ALL C.UTF-8  
ENV PATH=/opt/bin:$PATH
COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt
RUN /root/.setup

RUN vim +PlugInstall +qall
WORKDIR /root/workspace/

EXPOSE 3000 8080
