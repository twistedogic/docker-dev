FROM buildpack-deps:buster

ARG VIM_VERSION=8.1.2311
ARG TMUX_VERSION=2.9
ARG NCURSES_VERSION=6.0
ARG LIBEVENT_VERSION=2.0.22-stable
ARG BUILD_DIR=/build
ARG TARGET_DIR=/opt

WORKDIR ${TARGET_DIR}
WORKDIR ${BUILD_DIR}
ADD ./setup /root/.setup 

# ADD https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz /tmp/libevent.tar.gz
# RUN tar -C ${BUILD_DIR} -zxf /tmp/libevent.tar.gz
# RUN cd ${BUILD_DIR}/libevent-${LIBEVENT_VERSION} && \
#   ./configure --prefix=${BUILD_DIR} && make && make install

# ADD https://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz /tmp/ncurses.tar.gz
# RUN tar -C ${BUILD_DIR} -zxf /tmp/ncurses.tar.gz
# RUN cd ${BUILD_DIR}/ncurses-${NCURSES_VERSION} && \
#   ./configure \
#     --prefix=${BUILD_DIR} \
#     --with-default-terminfo-dir=/usr/share/terminfo \
#     --with-terminfo-dirs="/etc/terminfo:/lib/terminfo:/usr/share/terminfo" \
#     --enable-pc-files \
#     --with-pkg-config-libdir=${HOME}/local/lib/pkgconfig && \
#   make && make install

ADD https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz /tmp/tmux.tar.gz
RUN tar -C ${BUILD_DIR} -zxf /tmp/tmux.tar.gz
RUN cd ${BUILD_DIR}/tmux-${TMUX_VERSION} && \
  PKG_CONFIG_PATH=$TARGETDIR/lib/pkgconfig ./configure \
    --enable-static \
    --prefix=${TARGET_DIR} && \
  make && make install

ADD https://github.com/vim/vim/archive/v${VIM_VERSION}.tar.gz /tmp/vim.tar.gz
RUN tar -C ${BUILD_DIR} -zxf /tmp/vim.tar.gz
RUN cd ${BUILD_DIR}/vim-${VIM_VERSION} && \
  LDFLAGS="-static" ./configure \
    --disable-channel \
    --disable-gpm \
    --disable-gtktest \
    --disable-gui \
    --disable-netbeans \
    --disable-nls \
    --disable-selinux \
    --disable-smack \
    --disable-sysmouse \
    --disable-xsmp \
    --enable-multibyte \
    --with-features=huge \
    --without-x \
    --prefix=${TARGET_DIR} && \
  make && make install

