#!/bin/bash

#let's create a user to ssh into
SSH_USERPASS=`pwgen -c -n -1 12`
groupadd openproject
useradd --create-home -g openproject -g sudo openproject
chown openproject /home/openproject
echo openproject:$SSH_USERPASS | chpasswd
echo ssh openproject password: $SSH_USERPASS
echo $SSH_USERPASS > /root/openproject-root-pw.txt

# Install rbenv and ruby-build
git clone --depth 1 https://github.com/sstephenson/rbenv.git /home/openproject/.rbenv
git clone --depth 1 https://github.com/sstephenson/ruby-build.git /home/openproject/.rbenv/plugins/ruby-build

echo 'export RBENV_ROOT=/home/openproject/.rbenv' >> /etc/profile.d/rbenv.sh # or /etc/profile
echo 'export PATH=/home/openproject/.rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh # or /etc/profile
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile

echo 'export RBENV_ROOT=/home/openproject/.rbenv' >> /home/openproject/.bashrc
echo 'export PATH=/home/openproject/.rbenv/bin:$PATH' >> /home/openproject/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/openproject/.bashrc

/home/openproject/.rbenv/plugins/ruby-build/install.sh
. /etc/profile.d/rbenv.sh
rbenv install 2.1.0
rbenv global 2.1.0

#mysql has to be started this way as it doesn't work to call from /etc/init.d
/usr/bin/mysqld_safe &
sleep 7s

MYSQL_PASSWORD=`pwgen -c -n -1 15`
#This is so the passwords show up in logs.
echo mysql root password: $MYSQL_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt

mysqladmin -u root password $MYSQL_PASSWORD
#mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE openproject; GRANT ALL PRIVILEGES ON openproject.* TO 'openproject'@'localhost' IDENTIFIED BY '$OPENPROJECT_DB_PASSWORD'; FLUSH PRIVILEGES;"

# Download openproject and some public plugins
cd /home/openproject
git clone -b stable --depth 1 https://github.com/opf/openproject.git
cd openproject
git checkout stable
rbenv local 2.1.0
mv /Gemfile.plugins /home/openproject/openproject/Gemfile.plugins
mv /Gemfile.local /home/openproject/openproject/Gemfile.local

cat <<__EOF__ > /home/openproject/openproject/config/database.yml
production:
  adapter: mysql2
  database: openproject
  host: localhost
  username: root
  password: `echo $MYSQL_PASSWORD`
  encoding: utf8

development:
  adapter: mysql2
  database: openproject
  host: localhost
  username: root
  password: `echo $MYSQL_PASSWORD`
  encoding: utf8

test:
  adapter: mysql2
  database: openproject_test
  host: localhost
  username: root
  password: `echo $MYSQL_PASSWORD`
  encoding: utf8

__EOF__


gem install bundler
# because of 'very good reasons'(tm) we need to source rbenv.sh again, so that it finds the bundle command
. /etc/profile.d/rbenv.sh

bundle install
bundle exec rake db:create:all
bundle exec rake db:migrate
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:seed
bundle exec rake assets:precompile
bundle exec passenger start --runtime-check-only

killall mysqld
sleep 7s

chown -R openproject /home/openproject
