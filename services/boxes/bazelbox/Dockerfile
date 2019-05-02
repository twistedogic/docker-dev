FROM devbox:latest AS builder

FROM l.gcr.io/google/bazel:latest
MAINTAINER Jordan Li

COPY --from=builder /root/.setup /root/.setup
RUN /root/.setup

RUN vim +PlugInstall +qall

ENTRYPOINT /usr/bin/tmux

EXPOSE 3000 8080
