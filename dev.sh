#!/bin/bash
docker run --rm -it --name=dev \
        --privileged \
        -v /home/core/workspace:/root/workspace \
        -v /home/core/gopath:/go \
        -v /home/core/exercism:/root/exercism \
	-e "EMAIL=twistedogic@gmail.com" \
	-e "GIT_COMMITTER_EMAIL=twistedogic@gmail.com" \
	-e "GIT_COMMITTER_NAME=twistedogic" \
        -e "EXERCISM_API=" \
        -e "LANG=Zh_CN.utf8" \
        -p 8000:8000 -p 3000:3000 -p 35729:35729 -p 2222:22 \
        twistedogic/devbox /bin/bash
