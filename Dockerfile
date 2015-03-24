#
# this container is used for two things.
# abinit will create a new database and prime it with data to get started
# absql will run a database server (you should mount a database created with abinit)
#
FROM tacodata/abroute-docker-base

MAINTAINER Greg Fausak <greg@tacodata.com>

COPY PG.sql /usr/local/etc/
COPY abinit absql abadm.py /usr/local/bin/

EXPOSE 5432

VOLUME ["/var/lib/postgresql"]
VOLUME ["/etc/postgresql"]
VOLUME ["/run/postgresql"]

#CMD ["abinit"]
CMD ["absql"]
#CMD ["abadm.py"]
