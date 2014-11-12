docker stop $(docker ps -a -q)
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker rm -v $(docker ps -a -q)
docker run -d -p 3000:3000 nathanleclaire/wetty
