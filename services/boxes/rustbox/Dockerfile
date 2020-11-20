FROM devbox:latest as builder

FROM rust:slim
MAINTAINER Jordan Li

COPY --from=builder /root/.setup /root/.setup
COPY --from=builder /opt/bin/tmux /opt/bin/tmux
RUN /root/.setup

RUN rustup component add rls rust-analysis rust-src rustfmt

ADD vimrc.custom /root/.vimrc.custom
ADD vimrc.custom.plugins /root/.vimrc.custom.plugins
ADD init.vim /root/.config/nvim/init.vim
RUN sed -i '$ d' /root/.vimrc.plugins && \
  cat /root/.vimrc.custom.plugins >> /root/.vimrc.plugins && \ 
  echo "\ncall plug#end()" >> /root/.vimrc.plugins && \
  rm -rf /root/.vimrc.custom.plugins

ADD https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage /nvim.appimage
RUN chmod u+x /nvim.appimage && \
  /nvim.appimage --appimage-extract
ENV PATH /squashfs-root/usr/bin:/usr/local/cargo/bin:/opt/bin:$PATH

RUN nvim +PlugInstall +qall
WORKDIR /root/workspace/

RUN echo "PATH=$PATH" >> $HOME/.bashrc
RUN echo "alias vim=\"nvim\"" >> $HOME/.bashrc

EXPOSE 3000 8080
