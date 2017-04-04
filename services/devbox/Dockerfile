FROM google/debian:jessie
MAINTAINER Jordan Li
RUN apt-get update -y && \
    apt-get install -y -q silversearcher-ag tmux ssh curl vim \
    ruby python libelf1 libfontconfig python-dev python-pip \
    build-essential git ca-certificates \
    gdb ltrace strace && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN mkdir -p /var/run/sshd && chmod 755 /var/run/sshd

RUN echo "export PATH=$PATH" > /root/.bashrc

ADD tmux.conf /root/.tmux.conf
ADD vimrc /root/.vimrc
ADD vimrc.bundles /root/.vimrc.bundles
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall

EXPOSE 22
CMD /usr/sbin/sshd -D
