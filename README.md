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
docker run -name abdata tacodata/abroute_docker_postgres abinit
```

Once you have a database instance (called abdata) you use it like this:

```
docker run -name pgsql --volumes-from abdata tacodata/abroute_docker_postgres absql 
```

These two commands need to be run the first time, but, after that, you don't ever run the init
command again.  init is destructive, destroy the current database and recreates
a blank one.

## Docker Container Layout

![alt text][docker_containers]

The containers this repo is working on is the top one 'Postgres' and the 'db' container.
When we run our abinit script we create a volume suitable for mounting. In our example
above the init run creates an instance called 'abdata'. 'abdata' is represented by 'db'
in the picture. abdata provides two volumes. /var/lib/postgres contains the data for the database.
It is initialized with the 'adm' user and the 'sys' user.  It is suitable to
build an application on top. Also, the /run/postgresql is mountable and contains
the runtime information (basically the pid).


[docker_containers]:https://github.com/lgfausak/sqlauth/raw/master/docs/docker_containers.png "Docker Containers"
