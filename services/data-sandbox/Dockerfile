FROM twistedogic/codebox:latest
MAINTAINER Jordan Li
ENV XD_BUILD snapshot
ENV XD_VERSION 1.2.0.BUILD-SNAPSHOT

RUN apt-get update -y && \
    apt-get install -y openjdk-7-jre rsync wget unzip && \
    wget http://repo.spring.io/${XD_BUILD}/org/springframework/xd/spring-xd/${XD_VERSION}/spring-xd-${XD_VERSION}-dist.zip \
      -O /opt/spring-xd-${XD_VERSION}-dist.zip \
    && unzip /opt/spring-xd-${XD_VERSION}-dist.zip -d /opt/ \
    && rm /opt/spring-xd-${XD_VERSION}-dist.zip \
    && ln -s /opt/spring-xd-${XD_VERSION} /opt/spring-xd && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
