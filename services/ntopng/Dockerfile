FROM centos
MAINTAINER Jordan Li

RUN yum update -y
ADD epel.repo /etc/yum.repos.d/epel.repo
ADD ntop.repo /etc/yum.repos.d/ntop.repo
RUN yum clean all
RUN yum update -y
RUN yum install ntopng redis -y
RUN yum install -y openssh-server which
RUN mkdir -p /var/run/sshd && \
    echo "root:root" | chpasswd
RUN service sshd start
RUN service redis start
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
CMD /usr/sbin/sshd -D
