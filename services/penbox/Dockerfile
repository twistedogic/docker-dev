FROM devbox:latest AS builder

FROM kalilinux/kali-linux-docker:latest

RUN apt-get update -y && \
    apt-get install -y -q kali-linux kali-linux-wireless kali-linux-top10 \
    gdb ltrace strace && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV PATH=/opt/bin:$PATH
COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt /opt
RUN /root/.setup
RUN vim +PlugInstall +qall
