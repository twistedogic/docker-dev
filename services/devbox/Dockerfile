FROM debian:stretch
MAINTAINER Jordan Li

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get update -y && \
    apt-get install -y -q tmux curl vim-nox \
    ruby python libelf1 libfontconfig python-dev python-pip \
    build-essential cmake git ca-certificates \
    gdb ltrace strace && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN echo "export PATH=$PATH" > /root/.bashrc

ADD setup /root/.setup
RUN /root/.setup

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN vim +PlugInstall +qall

EXPOSE 3000 8080
