FROM twistedogic/storm
MAINTAINER twistedogic

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 8000

RUN /usr/bin/config-supervisord.sh supervisor
RUN /usr/bin/config-supervisord.sh logviewer
ADD start-supervisor.sh /usr/local/bin/start-supervisor
RUN chmod +x /usr/local/bin/start-supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/local/bin/start-supervisor"]




