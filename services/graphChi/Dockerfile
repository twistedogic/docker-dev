FROM twistedogic/worker
MAINTAINER twistedogic
RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc g++ build-essential libopenmpi-dev openmpi-bin cmake zlib1g-dev git 

RUN git clone https://github.com/GraphChi/graphchi-cpp.git /graphchi
RUN chmod +x /graphchi/install.sh
RUN cd /graphchi && ./install.sh

EXPOSE 22
CMD ["/usr/sbin/sshd -D"]
