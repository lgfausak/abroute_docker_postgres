# abroute_docker_postgres - autobahn postgres database for sqlauth
This creates a database instance for the sqlauth autobahn program.
It seeds it with initial data.  It can be used as the
core of a larger project that needs integrated security and permissions.

## Overview

The postgres container defined herein can do two things:

* run and server postgres
* create, backup, replicate, restore db

The intent is to use this container as the data container as
well as the actual postgres container.  That is, this container
mounts another instance of this container.
Usage will be something like this:

Initial DB Creation

```
docker run -name abdata tacodata/abroute_docker_postgres init
```

Once you have a database instance (called abdata) you use it like this:

```
docker run -name pgsql --volumes-from abdata tacodata/abroute_docker_postgres sql 
```

These two commands need to be run the first time, but, after that, you don't ever run the init
command again.  init is destructive, destroy the current database and recreates
a blank one.

## Docker Container Layout

![alt text][docker_containers]

reasons.  There isn't any reason the code in these two places couldn't
do a call to the db.info rpc to determine the type of database that is
connected, then customize the query accordingly.  I'm just not concerned
with database portability at this moment, so I am stopping work on this
aspect.  Contact me if you need help writing a driver for a different
database, I would be happy to help.

[docker_containers]:https://github.com/lgfausak/sqlauth/raw/master/docs/docker_containers.png "Docker Containers"

