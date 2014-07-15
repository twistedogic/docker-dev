# runnable base
FROM twistedogic/worker

# REPOS
RUN apt-get -y update
RUN wget -q -O /opt/ufasoft_coin-miner-0.68-x64-portable.tar.xz http://darkgamex.ch/ufasoft/ufasoft_coin-miner-0.68-x64-portable.tar.xz
RUN cd /opt && tar xvfJ ufasoft_coin-miner-0.68-x64-portable.tar.xz
ENV LD_LIBRARY_PATH /opt/ufasoft_coin-miner-0.68-x64-portable/libs
ENTRYPOINT    ["/opt/ufasoft_coin-miner-0.68-x64-portable/bin/coin-miner"] 
