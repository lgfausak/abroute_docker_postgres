FROM phusion/baseimage

MAINTAINER Greg Fausak <greg@tacodata.com>

ENV PG_VERSION 9.4
RUN apt-get update \
 && apt-get install -y wget \
 && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update \
 && apt-get install -y postgresql-${PG_VERSION} \
                       postgresql-server-dev-${PG_VERSION} \
                       postgresql-client-${PG_VERSION} \
                       postgresql-contrib-${PG_VERSION} pwgen \
                       python-dev python-pip
 && rm -rf /var/lib/postgresql \
 && rm -rf /var/lib/apt/lists/* # 20150220 \
 && mkdir -p /usr/local/abin \
 && chmod 755 /usr/local/abin \
 && pip install sqlauth

COPY abenv abinit absql /usr/local/abin/
RUN chmod 755 \
    /usr/local/abin/abinit \
    /usr/local/abin/absql

EXPOSE 5432

VOLUME ["/var/lib/postgresql"]
VOLUME ["/run/postgresql"]

CMD ["/usr/local/abin/absql"]
