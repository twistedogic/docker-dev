sed -i s/MASTERIP/$1/g kubelet-worker.service
sed -i s/MASTERIP/$1/g proxy-worker.service

cp -rf *.service /etc/systemd/system/
systemctl enable kubelet-worker.service proxy-worker.service 
