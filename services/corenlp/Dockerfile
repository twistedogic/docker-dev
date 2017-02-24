FROM java:jre-alpine

MAINTAINER twistedogic@gmail

ENV CORENLP_VERSION 2016-10-31

RUN apk add --update --no-cache \
   unzip \
   wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-$CORENLP_VERSION.zip
RUN unzip stanford-corenlp-full-$CORENLP_VERSION.zip && \
  rm stanford-corenlp-full-$CORENLP_VERSION.zip

WORKDIR stanford-corenlp-full-$CORENLP_VERSION

RUN export CLASSPATH="`find . -name '*.jar'`"

ENV PORT 9000

EXPOSE $PORT

CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer

