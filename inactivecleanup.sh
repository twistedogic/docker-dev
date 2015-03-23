docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker rm -v $(docker ps -a -q)

