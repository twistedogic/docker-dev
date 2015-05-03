FROM google/ruby:latest
MAINTAINER Jordan Li
VOLUME /data
RUN gem install fakes3
CMD fakes3 server --port=4569 --root=ROOT -r /data
EXPOSE 4569
