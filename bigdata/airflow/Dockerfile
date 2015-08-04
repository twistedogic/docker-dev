FROM google/debian:wheezy
MAINTAINER Jordan Li
RUN apt-get update -y && apt-get install --no-install-recommends -y -q build-essential python2.7 gcc make python2.7-dev python-pip git wget bzip2 ca-certificates libmysqlclient-dev mysql-client libkrb5-dev libldap2-dev libsasl2-dev libssl-dev && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN pip install -U pip
ENV AIRFLOW_HOME /airflow
ENV C_FORCE_ROOT true  # run airflow worker by root
RUN pip install airflow[mysql]
ADD entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
VOLUME ["/airflow/dags", "/airflow/logs"]
EXPOSE 8080
EXPOSE 5555
EXPOSE 8793

CMD ["/root/entrypoint.sh"]
