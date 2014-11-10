docker run -d --name hello.1 busybox /bin/sh -c "while true; do echo hello world; sleep 1; done"
docker run -d --name hello.2 busybox /bin/sh -c "while true; do echo hello world; sleep 1; done"
docker run -d --name hello.3 busybox /bin/sh -c "while true; do echo bye world; sleep 1; done"
