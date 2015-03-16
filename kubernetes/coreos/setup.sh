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
cd /etc/systemd/system
cat > apiserver.service << EOF
[Unit]
Description=Kubernetes API Server
After=etcd.service
After=docker.service
Wants=etcd.service
Wants=docker.service

[Service]
ExecStart=/opt/bin/kube-apiserver \
--address=127.0.0.1 \
--port=8080 \
--etcd_servers=http://127.0.0.1:4001 \
--portal_net=10.100.0.0/16 \
--logtostderr=true
ExecStartPost=-/bin/bash -c "until /usr/bin/curl http://127.0.0.1:8080; do echo \"waiting for API server to come online...\"; sleep 3; done"
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
cat > apiserver.service << EOF
[Unit]
Description=Kubernetes Controller Manager
After=etcd.service
After=docker.service
After=apiserver.service
Wants=etcd.service
Wants=docker.service
Wants=apiserver.service

[Service]
ExecStart=/opt/bin/kube-controller-manager \
--master=http://127.0.0.1:8080 \
--machines=10.0.0.129,10.0.0.130,10.0.0.131
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

cat > scheduler.service << EOF
[Unit]
Description=Kubernetes Scheduler
After=etcd.service
After=docker.service
After=apiserver.service
Wants=etcd.service
Wants=docker.service
Wants=apiserver.service

[Service]
ExecStart=/opt/bin/kube-scheduler --master=127.0.0.1:8080
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

cat > flannel.service << EOF
[Unit]
Description=Flannel network fabric for CoreOS
Requires=etcd.service
After=etcd.service

[Service]
EnvironmentFile=/etc/environment
ExecStartPre=-/bin/bash -c "until /usr/bin/etcdctl set /coreos.com/network/config '{\"Network\": \"10.100.0.0/16\"}'; do echo \"waiting for etcd to become available...\"; sleep 5; done"
ExecStart=/opt/bin/flannel --iface=${COREOS_PRIVATE_IPV4}
ExecStartPost=-/bin/bash -c "until [ -e /run/flannel/subnet.env ]; do echo \"waiting for write.\"; sleep 3; done"
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

cat > docker.service << EOF
[Unit]
Description=Docker container engine configured to run with flannel
Requires=flannel.service
After=flannel.service

[Service]
EnvironmentFile=/run/flannel/subnet.env
ExecStartPre=-/usr/bin/ip link set dev docker0 down
ExecStartPre=-/usr/sbin/brctl delbr docker0
ExecStart=/usr/bin/docker -d -s=btrfs -H fd:// --bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU}
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

cat > proxy.service << EOF
[Unit]
Description=Kubernetes proxy server
After=etcd.service
After=docker.service
Wants=etcd.service
Wants=docker.service

[Service]
ExecStart=/opt/bin/kube-proxy -etcd_servers=http://127.0.0.1:4001 --logtostderr=true
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

cat > kubelet.service << EOF
[Unit]
Description=Kubernetes Kubelet
After=etcd.service
After=docker.service
Wants=etcd.service
Wants=docker.service

[Service]
EnvironmentFile=/etc/environment
ExecStart=/opt/bin/kubelet \
--address=${COREOS_PRIVATE_IPV4} \
--port=10250 \
--hostname_override=${COREOS_PRIVATE_IPV4} \
--etcd_servers=http://127.0.0.1:4001 \
--logtostderr=true
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl enable *
