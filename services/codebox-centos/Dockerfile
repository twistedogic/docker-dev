FROM centos:7
MAINTAINER Jordan Li
RUN yum update -y && yum install -y curl python git epel-release gcc gcc-c++ make
RUN yum update -y && yum install -y nodejs npm

RUN \
  echo "# Install OpenSSH Server" ;\
  yum install openssh-server ;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true
RUN npm install -g node-gyp
RUN npm install -g codebox

# Rebuild pty.js
# codebox cannot find module ../build/Release/pty.node if don't rebuild pty.js
# http://stackoverflow.com/questions/23570023/issues-in-finding-node-package-when-running-codebox
RUN cd /usr/lib/node_modules/codebox/node_modules/shux/node_modules/pty.js \
    && make clean && make

RUN mkdir -p /workspace
WORKDIR /workspace
EXPOSE 8000
ENTRYPOINT ["codebox", "run"]
