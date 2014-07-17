#runnable base
FROM twistedogic/worker

# REPOS
RUN apt-get -y update
RUN wget -q -O /opt/pooler-cpuminer-2.4-linux-x86_64.tar.gz http://sourceforge.net/projects/cpuminer/files/pooler-cpuminer-2.4-linux-x86_64.tar.gz
RUN cd /opt && tar zxf pooler-cpuminer-2.4-linux-x86_64.tar.gz
ENTRYPOINT    ["/opt/minerd"] 
