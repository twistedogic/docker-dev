FROM ubuntu:quantal
MAINTAINER dominik.burgdoerfer@gmail.com

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    python-software-properties software-properties-common wget
RUN wget --quiet -O - \
    https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" \
    >/etc/apt/sources.list.d/pgdg.list
RUN echo "deb http://nightly.openerp.com/7.0/nightly/deb/ ./" \
    >/etc/apt/sources.list.d/openerp.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
    postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 \
    openssh-server \
    supervisor \
    sudo \
    pwgen
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes -q openerp
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./start.sh /start
EXPOSE 22 8069
CMD ["/start"]
