FROM ubuntu:precise
MAINTAINER twistedogic

# Add PPA for the necessary JDK
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update
## DEPENDENCIES ##
RUN apt-get update && apt-get install --assume-yes python-software-properties curl default-jdk git supervisor tomcat7 openssh-server && \
    mkdir /var/run/sshd && chmod 700 /var/run/sshd && \
    echo 'root:root' | chpasswd
# install maven from a PPA, it doesn't seem to be in the Docker Ubuntu distro.
RUN add-apt-repository ppa:natecarlson/maven3
RUN apt-get update && apt-get install --assume-yes maven

# Preemptively accept the Oracle License
RUN echo "oracle-java7-installer	shared/accepted-oracle-license-v1-1	boolean	true" > /tmp/oracle-license-debconf
RUN /usr/bin/debconf-set-selections /tmp/oracle-license-debconf
RUN rm /tmp/oracle-license-debconf

# Install the JDK
RUN apt-get install -y oracle-java7-installer oracle-java7-set-default
RUN apt-get update

# Install Cassandra
RUN echo "deb http://debian.datastax.com/community stable main" | tee -a /etc/apt/sources.list.d/datastax.sources.list
RUN curl -L http://debian.datastax.com/debian/repo_key | apt-key add -
RUN apt-get update
RUN apt-get install -y dsc20

# Deploy startup script
ADD init.sh /usr/local/bin/cass-dock
RUN chmod 755 /usr/local/bin/cass-dock

# Deploy shutdown script
ADD shutdown.sh /usr/local/bin/cass-stop
RUN chmod 755 /usr/local/bin/cass-stop

RUN mkdir /maven

ENV TOMCAT_VERSION 7.0.53
ENV DEPLOY_DIR /maven

RUN wget http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz

# Unpack
RUN tar xzf /tmp/catalina.tar.gz -C /opt
RUN ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
RUN rm /tmp/catalina.tar.gz

# Add roles
ADD tomcat-users.xml /opt/apache-tomcat-${TOMCAT_VERSION}/conf/

# Startup script
ADD deploy-and-run.sh /opt/apache-tomcat-${TOMCAT_VERSION}/bin/

# Remove unneeded apps
RUN rm -rf /opt/tomcat/webapps/examples
RUN rm -rf /opt/tomcat/webapps/docs

# Replace "random" with "urandom" for quicker startups
RUN rm /dev/random && ln -s /dev/urandom /dev/random

# VOLUME ["/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root"

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

RUN git clone https://github.com/usergrid/usergrid.git /opt/usergrid
ADD ./usergrid-deployment.properties /opt/usergrid/stack/config/src/main/resources/usergrid-default.properties
RUN cd /opt/usergrid/stack && mvn clean install -DskipTests=true
RUN mv /opt/usergrid/stack/rest/target/ROOT.war /maven/ROOT.war
RUN rm -rf /opt/apache-tomcat-7.0.53/webapps/ROOT
RUN rm -rf /opt/tomcat/webapps/ROOT

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 7199 7000 7001 9160 9042 8080 22
CMD ["/usr/bin/supervisord"]
