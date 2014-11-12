FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install supervisor openstack-dashboard apache2 libapache2-mod-wsgi memcached python-memcache -y
ADD ./setting.py /etc/openstack-dashboard/local_settings.py
RUN mkdir -p /var/log/supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80
CMD ["/usr/bin/supervisord"]
