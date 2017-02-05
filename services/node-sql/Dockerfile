FROM node:7.5
MAINTAINER Jordan Li
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/local/bin/dumb-init
RUN npm install -g phantomjs
ADD ./scrape.js /root/scrape.js
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "phantomjs", "/root/scrape.js"]
