FROM devbox:latest AS builder

FROM l.gcr.io/google/bazel:latest
MAINTAINER Jordan Li

ENV PATH=/opt/bin:$PATH
COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt

RUN /root/.setup

RUN vim +PlugInstall +qall

ENTRYPOINT /opt/bin/tmux
WORKDIR /root/workspace/

EXPOSE 3000 8080
