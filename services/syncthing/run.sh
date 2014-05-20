#/bin/bash
nohup /usr/bin/syncthing &
sleep 10
ps -ef | grep "your_process" | awk '{print $2}' | xargs kill
sed -i "s|127.0.0.1:8080|0.0.0.0:8080|" /.config/syncthing/config.xml
/usr/bin/syncthing
