FROM google/debian:wheezy
MAINTAINER Jordan Li
ENV HOME /root
RUN apt-get update -y && apt-get install -y build-essential ruby python python-pip python-dev ctags \
    ssh curl wget make mercurial libxpm-dev libx11-dev libxt-dev ncurses-dev git && \
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
RUN mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle && \
    wget -P $HOME/.vim/autoload https://tpo.pe/pathogen.vim && \
    echo "execute pathogen#infect()" >> $HOME/.vimrc && \
    echo "syntax on"                 >> $HOME/.vimrc && \
    echo "filetype plugin indent on" >> $HOME/.vimrc
RUN pip install twisted argparse
RUN cd $HOME/.vim/bundle && git clone git://github.com/FredKSchott/CoVim.git

EXPOSE 22
CMD /root/ssh_key_adder.rb && /usr/sbin/sshd -D
