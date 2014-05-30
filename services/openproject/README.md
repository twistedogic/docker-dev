# OpenProject Docker

```
WARNING: The OpenProject docker setup is still under heavy development.
```

A Dockerfile that installs OpenProject.
Actually it installs `sshd`, `memcached`, `mysql server`, `rbenv`, `ruby 2.1`, `passenger`,and a fresh `openproject` development snapshot.

Please keep in mind, that we do **not** recommend to use the produced Docker image in production.
Why?
Because the docker team says that docker ["should not be used in production"](https://www.docker.io/learn_more/),
your data is not persisted (we'll talk about that later), there are no backups, no monitoring etc.

However, we strive to make our docker image secure and stable, so that we/you can use it in production in the future.

## Installation

First [install docker](https://www.docker.io/). Then do the following to build an OpenProject image (this may take some time):

```bash
$ git clone https://github.com/opf/openproject-docker.git
$ cd openproject-docker
$ docker build --rm -t openproject_evaluation .
```

**NOTE:** depending on your docker installation, you might need to prepend `sudo ` to your `docker` commands

## Usage

To spawn a new instance of OpenProject on port 80 of your host machine:

```bash
$ docker run -p 80:8080 -d openproject_evaluation
```

The `-d` flag lets docker start the image in the background and prints the container id to stdout.

You can the visit the following URL in a browser on your host machine to get started:

```
http://127.0.0.1:8080
```

## Get a shell on your OpenProject image

Concurrently with the OpenProject server, we start an ssh daemon which listens on the default port 22.
To connect to your OpenProject image, you have to tell docker to connect that port.
Start your image with the additional port:

```bash
$ docker run -p 8080 -p 20 -d openproject_evaluation
```

You may find out which of your local ports is mapped to the image-22-port with `docker port` and connect to your image:

```bash
$ ssh -p <port> openproject@localhost
$ openproject@localhost's password:
```

Well, we need a password now. The openproject account is secured with a random password.
We set that password during the image setup - watch for a line like `ssh openproject password: <random password>`
during the `docker build -t="openproject_evaluation" .` step.

## Further thoughts

### Persist your data

Everything OpenProject needs lies within its docker image. That includes the database and uploaded files (and log data, and maybe some repositories).
The time may come when you want to use a new OpenProject docker image (e.g. when a new OpenProject version was released) and we need to take care
of the data stored in your old image.

We don't have a good solution built-in yet, but there is [a promising blog post](http://www.tech-d.net/2013/12/16/persistent-volumes-with-docker-container-as-volume-pattern/)
from [Brian Goff](https://github.com/cpuguy83).

Brian proposes to use two docker containers - One for the app and another one for the data.
Now, the application container can mount directories from the data-container.
You can easily backup your data container, or replace your app container.

The places we need to take care of for OpenProject are:

* `RAILS_ROOT/files` - all files which are uploaded are placed here
* `/var/lib/mysql` - the place where MySQL stores its database
* `RAILS_ROOT/log` - the OpenProject logfiles, in case you care
* if you have configured OpenProject to use/create local repositories, the place where you store those repositories

### Update the OpenProject code base

To upgrade your OpenProject installation, ssh into your container and do a `git pull` within the OpenProject directory.
A `bundle install`, `bundle exec rake db:migrate`, and `bundle exec rake assets:precompile` should finish the upgrade.

Now restart your container and a new OpenProject should be running.

As always: If you care about your data, do a backup before upgrading!

### E-Mail Setup

As a default the OpenProject docker image does **not** send any mails to anyone.
To change that you must specify an smtp account from which OpenProject can send mails through environment variables.
You can do that when starting the OpenProject docker image like this:

```bash
docker run -d \
  -p 8080 -p 20
  -e "EMAIL_DELIVERY_METHOD=smtp" \
  -e "SMTP_ADDRESS=smtp.gmail.com" \
  -e "SMTP_PORT=587" \
  -e "SMTP_DOMAIN=smpt.gmail.com" \
  -e "SMTP_AUTHENTICAITON=plain" \
  -e "SMTP_ENABLE_STARTTLS_AUTO=true" \
  -e "SMTP_USER_NAME=user" \
  -e "SMTP_PASSWORD=password" \
  openproject_evaluation
```

Of course you have to insert the your `user`, `password`, etc. values.
The settings above (except maybe the username and password) should work for a standard gmail account.

Please also visit the `Modules -> Administration -> Settings -> Email notifications` page for further settings.

### OpenProject plug-ins

We have included some OpenProject plug-ins into the docker image. However, you can change the list of plug-ins (and install some themes, or even remove all the plug-ins).
To do this, edit the `files/Gemfile.plugins` file before you build.

### Use an external database

Through defining the `DATABASE_URL` environment variable you may use an external database. Currently we support MySQL and PostgreSQL databases.

The variable must be set when starting the OpenProject docker image:

```bash
docker run -d \
  -p 8080 -p 20
  -e "DATABASE_URL=mysql2://user:password@host/db" \
  openproject_evaluation
```

Of course you have to insert the correct `user`, `password`, `host` and `db` (database name).

**Note:** for a PostgreSQL database, let your URI start with `postgres://` instead of `mysql2://`.

**Note:** make sure, that your external database is set-up correctly!
It must be accessible, the user must exist and have appropriate rights to the OpenProject database, and the schema must be up-to-date (run `bundle exec rake db:migrate` targeted at your remote database to update the schema).

### Features which we'd love to have

* make the admin change his password on the first login
* nice seed data
* an additional image (or instructions) for 'easy' development
* ssh-login with a different user (so that we can remove the openproject user from the sudoers list)
* have a smallter image size

## Contribute

We are happy for any contribution :) You may either

* make a Pull Request (which we favor ;))
* [open a new issue](https://www.openproject.org/projects/docker/work_packages/new) at our bug tracker
* or discuss [at the forums](https://www.openproject.org/projects/openproject/boards)

## License

This work is licensed under the GPLv3 - see [COPYRIGHT.md](COPYRIGHT.md) for details.
