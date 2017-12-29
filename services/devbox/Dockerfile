FROM google/debian:jessie
MAINTAINER Jordan Li
RUN apt-get update -y && \
    apt-get install -y -q tmux curl vim \
    ruby python libelf1 libfontconfig python-dev python-pip \
    build-essential git ca-certificates \
    gdb ltrace strace && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN echo "export PATH=$PATH" > /root/.bashrc

ADD setup /root/.setup
RUN /root/.setup
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall

EXPOSE 3000 8080
