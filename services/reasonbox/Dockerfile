FROM debian:stretch
MAINTAINER Jordan Li <twistedogic@gmail.com>

ENV NODE_VERSION v8.11.1
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz

RUN apt-get update -y && \
    apt-get install -y curl xz-utils vim git locales tmux \
    build-essential libssl-dev libffi-dev python3 && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN curl -SLO "$NODE_DOWNLOAD_URL" \ 
  && tar xf node-$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1 \
  && rm node-$NODE_VERSION-linux-x64.tar.xz
RUN ln -s $(which python3) /usr/local/bin/python
RUN npm install -g yarn
RUN yarn global add bs-platform reason-cli@3.1.0-linux ocaml-language-server create-react-app reason-scripts
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ADD vimrc /root/.vimrc
ADD tmux.conf /root/.tmux.conf
RUN vim +PlugInstall +qall
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
