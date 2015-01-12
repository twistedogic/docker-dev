marathonHost={$marathonHost:-127.0.0.1:8080}
node /data/app.js $marathonHost $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v '172.17.42.1') 
