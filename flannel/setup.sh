cp -rf *.service /etc/systemd/system
systemd enable docker-bootstrap.service
systemd enable etcd-setup.service
systemd enable flanneld-setup.service
systemd enable docker.service
systemd enable etcd.service
systemd enable flanneld.service
