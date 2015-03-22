FROM phusion/baseimage

MAINTAINER Greg Fausak <greg@tacodata.com>

ENV PG_VERSION 9.4
RUN apt-get update \
 && apt-get install -y wget \
 && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update \
 && apt-get install -y postgresql-${PG_VERSION} \
                       postgresql-client-${PG_VERSION} \
                       postgresql-contrib-${PG_VERSION} pwgen \
 && rm -rf /var/lib/postgresql \
 && rm -rf /var/lib/apt/lists/* # 20150220 \
 && mkdir -p /usr/local/abin /usr/local/aetc \
 && chmod 755 /usr/local/abin

COPY PG.sql abenv ab abinit absql /usr/local/abin/
RUN chmod 755 \
    /usr/local/abin/abinit \
    /usr/local/abin/absql

EXPOSE 5432

VOLUME ["/var/lib/postgresql"]
VOLUME ["/etc/postgresql"]
VOLUME ["/run/postgresql"]

ENTRYPOINT ["/usr/local/abin/ab"]
CMD ["absql"]
