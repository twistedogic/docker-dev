FROM dockerfile/nodejs
MAINTAINER twistedogic
RUN cd /home && npm install tracegl
EXPOSE 2000 2080
ENTRYPOINT ["/home/node_modules/tracegl.js"]

