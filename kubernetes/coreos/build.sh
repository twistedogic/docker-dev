mkdir -p /opt/bin
docker run -i -t google/golang /bin/bash -c "go get github.com/coreos/flannel"
docker cp $(docker ps -l -q):/gopath/bin/flannel /opt/bin/
docker rm -v $(docker ps -l -q)
cd /root
git clone https://github.com/GoogleCloudPlatform/kubernetes.git
cd kubernetes/build
./release.sh
cd /root/kubernetes/_output/dockerized/bin/linux/amd64
cp * /opt/bin

