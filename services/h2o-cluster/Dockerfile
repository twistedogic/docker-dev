FROM dockerfile/java
MAINTAINER Jordan Li
RUN wget http://h2o-release.s3.amazonaws.com/h2o/rel-mirzakhani/2/h2o-2.8.3.2.zip -O /opt/h2o-2.8.3.2.zip --no-check-certificate
RUN cd /opt && unzip h2o-2.8.3.2.zip
CMD ["java","-Xmx1g","-jar","/opt/h2o-2.8.3.2/h2o.jar"]
