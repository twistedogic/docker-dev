sed -i s/MASTERIP/$1/g flanneld.service
cp -rf *.service /etc/systemd/system
systemctl enable docker-bootstrap.service
systemctl enable etcd-setup.service
systemctl enable flanneld-setup.service
systemctl enable docker.service
systemctl enable etcd.service
systemctl enable flanneld.service
systemctl enable remove-docker0.service
systemctl daemon-reload
