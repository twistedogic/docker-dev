FROM google/nodejs:latest
MAINTAINER Jordan Li
ENV HOME /root
RUN apt-get update -y && apt-get install -y build-essential ruby python python-pip python-dev ctags \
    ssh curl wget make mercurial libxpm-dev libx11-dev libxt-dev ncurses-dev git tmux && \
    cd /tmp && \
    hg clone https://code.google.com/p/vim/ && \
    cd /tmp/vim && \
    ./configure --with-features=big \
                #needed for editing text in languages which have many characters
                --enable-multibyte \     
                #python interop needed for some of my plugins
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --disable-gui \
                --disable-netbeans \
                --prefix /usr && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim74 && \
    make install && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
ADD ssh_key_adder.rb /root/ssh_key_adder.rb
RUN gem install github-auth && \
    chmod +x /root/ssh_key_adder.rb && \
    mkdir /var/run/sshd && \
    echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config
RUN pip install twisted argparse
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
ADD tmux.conf /root/.tmux.conf
ADD vimrc /root/.vimrc
ADD vimrc.bundles /root/.vimrc.bundles
RUN echo "vim +PluginInstall +qall" > /root/vimsetup

EXPOSE 22
CMD /root/ssh_key_adder.rb && /usr/sbin/sshd -D
