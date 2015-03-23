yum -y install golang
yum -y install bridge-utils 
git clone https://github.com/coreos/etcd.git /opt/etcd
cd /opt/etcd
git checkout v0.4.6
./build
cp bin/etcd /usr/local/sbin/.
 
git clone https://github.com/coreos/etcdctl.git /opt/etcdctl
cd /opt/etcdctl
git checkout v0.4.5
./build
cp bin/etcdctl /usr/local/sbin/.
 
yum -y install kernel-headers
git clone https://github.com/coreos/flannel.git /opt/flannel
cd /opt/flannel
git checkout v0.1.0
./build
cp bin/flanneld /usr/local/sbin/.
