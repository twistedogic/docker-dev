#!/bin/bash

export USER=openproject
export HOME=/home/$USER
export RBENV_ROOT=$HOME/.rbenv
export RAILS_CACHE_STORE=memcache
export PATH=$RBENV_HOME/bin:$PATH
eval "$(rbenv init -)"
export RAILS_ENV=production

cd $HOME/openproject
rbenv local 2.1.0
bundle exec passenger start
