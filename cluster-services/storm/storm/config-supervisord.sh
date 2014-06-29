echo [program:storm-$1] | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo command=/usr/local/storm/bin/storm $1 | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo stdout_logfile=/var/log/supervisor/storm-$1.log | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo stderr_logfile=/var/log/supervisor/storm-$1.log | tee -a /etc/supervisor/conf.d/storm-$1.conf
echo autorestart=true | tee -a /etc/supervisor/conf.d/storm-$1.conf
