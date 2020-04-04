FROM devbox:latest as builder

FROM python:3.8-slim
MAINTAINER Jordan Li

ENV LC_ALL C.UTF-8  
ENV PATH=/opt/bin:/root/.local/bin:$PATH
COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt
RUN /root/.setup
RUN python3 -m pip install pipx
RUN pipx install pipenv
RUN vim +PlugInstall +qall
WORKDIR /root/workspace/

EXPOSE 3000 8080
