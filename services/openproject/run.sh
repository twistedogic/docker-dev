#/bin/bash

docker run -d -p 3306:3306 -p 80:8080 -p 9002:22 -v /home/vagrant/data/openproject:/var/lib/mysql openproject
