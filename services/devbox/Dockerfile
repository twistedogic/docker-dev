FROM google/debian:jessie
MAINTAINER Jordan Li
RUN apt-get update -y && \
    apt-get install -y -q silversearcher-ag tmux ssh curl vim \
    ruby python libelf1 python-dev python-pip \
    build-essential git ca-certificates && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN mkdir -p /var/run/sshd && chmod 755 /var/run/sshd

ENV GOLANG_VERSION 1.7.3
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOPATH /go
ENV NODE_VERSION v6.9.1
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN echo "export PATH=$PATH" > /root/.bashrc
RUN echo "export GOPATH=$GOPATH" >> /root/.bashrc
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN curl -SLO "$NODE_DOWNLOAD_URL" \ 
  && tar xf node-$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1 \
  && rm node-$NODE_VERSION-linux-x64.tar.xz
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz

ADD tmux.conf /root/.tmux.conf
ADD vimrc /root/.vimrc
ADD vimrc.bundles /root/.vimrc.bundles
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall

RUN npm install -g yarn

EXPOSE 22
CMD /usr/sbin/sshd -D
