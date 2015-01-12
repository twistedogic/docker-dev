FROM twistedogic/worker
MAINTAINER Jordan Li	
# Set correct environment variables.
ENV HOME /root
## apt-get update
## oracle-java8
RUN apt-get -y update
RUN apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository ppa:webupd8team/java && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y build-essential software-properties-common \
                       python \
                       git byobu wget curl unzip tree elinks \
                       oracle-java7-installer oracle-java7-set-default ant \
                       lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6 supervisor
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
## Development Environment
ENV USERNAME root
ENV PATH $PATH:${HOME}/bin
WORKDIR /data
ENV DATA_DIR /data
RUN mkdir -p /data && \
    chown -R ${USERNAME}:${USERNAME} ${HOME} ${DATA_DIR}
USER ${USERNAME}
## Android SDK
ENV ANDROID_SDK_VERSION r24.0.2
ENV ANDROID_API_LEVEL 19
ENV ANDROID_BUILD_TOOLS_VERSION 21.1.1
ENV ANDROID_HOME ${HOME}/android-sdk-linux
RUN echo 'export ANDROID_HOME=${ANDROID_HOME}' >> ${HOME}/.profile
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN echo 'export PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools' >> ${HOME}/.profile
RUN wget -qO- "http://dl.google.com/android/android-sdk_${ANDROID_SDK_VERSION}-linux.tgz" \
    | tar -zxv -C ${HOME} && \
    echo y | android update sdk --no-ui --all --filter platform-tool,android-${ANDROID_API_LEVEL},sysimg-${ANDROID_API_LEVEL},build-tools-${ANDROID_BUILD_TOOLS_VERSION}
ENV NODE_VERSION v0.10
## Node.js/Cordova/Ionic
RUN npm install -g cordova ionic ripple-emulator && \
    npm cache clear
## Create Cordova and ionic sample apps
RUN /bin/bash -c 'cd ${DATA_DIR} && \
    cordova create cordova_test com.example.test "CordovaTestApp" && \
    cd ${DATA_DIR}/cordova_test && \
    cordova platform add android && \
    cordova build && \
    cd ${DATA_DIR} && \
    ionic start ionicTestApp tabs && \
    cd ${DATA_DIR}/ionicTestApp && \
    ionic platform add android && \
    ionic build android'
USER root
ENV HOME /root
VOLUME ["/data"]
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 7777 8100 35729
CMD ["/usr/bin/supervisord"] 
