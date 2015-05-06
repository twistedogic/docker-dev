docker-centos-serf
=====

[Serf](https://www.serfdom.io/) : a tool for cluster membership, failure detection, and orchestration that is decentralized, fault-tolerant and highly available.

也安裝了 dnsmasq，container 的 nameserver 可設定為自己。

新增移除叢集節點時，會自動更新叢集節點 hostname 與 IP 的資訊。

使用方式
-----

執行 [fayehuang/centos-serf](https://hub.docker.com/u/fayehuang/centos-serf/) docker container

* 加入指定的叢集，**SERF_JOIN_IP**=1.1.1.1（叢集內任一節點 IP）

`docker run -d -p 2222:22 --name=node2 --hostname=node2.example.local --dns=127.0.0.1 -e SERF_JOIN_IP=<node_IP> fayehuang/centos-serf`

* 不加入叢集

`docker run -d -p 2222:22 --name=node1 --hostname=node1.example.local --dns=127.0.0.1 fayehuang/centos-serf`
