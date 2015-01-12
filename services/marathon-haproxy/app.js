var request = require('request');
var fs = require('fs');
var sys = require('sys')
var exec = require('child_process').exec;
var marathonIP = process.argv[2] || '192.168.100.77:8080';
var hostIP = process.argv[3]
var options = {
    url: 'http://' + marathonIP + '/v2/tasks',
    headers: {
        'Accept': 'text/plain'
    }
};

exec('haproxy -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid', function (error, stdout, stderr) {
        if (error !== null) {
            console.log('exec error: ' + error);
        }
    });

function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
        var config = "global\n" +
            "\tdaemon\n" +
            "\tlog 127.0.0.1 local0\n" +
            "\tlog 127.0.0.1 local1 notice\n" +
            "\tmaxconn 4096\n" +
            "defaults\n" +
            "\tlog            global\n" +
            "\tretries             3\n" +
            "\tmaxconn          2000\n" +
            "\ttimeout connect  5000\n" +
            "\ttimeout client  50000\n" +
            "\ttimeout server  50000\n" +
            "listen stats\n" +
            "\tbind 127.0.0.1:9090\n" +
            "\tbalance\n" +
            "\tmode http\n" +
            "\tstats enable\n" +
            "\tstats auth admin:admin\n";
        // console.log(body);
        var data = body.split('\n');
        // console.log(data.length);
        for (var i = 0; i < data.length - 1;i++){
            var line = data[i].split('\t');
            var appName = line[0];
            var appPort = line[1];
            for (var j = 2; j < line.length - 1;j++){
                var ip = line[j].split(':');
                if (ip[0] == hostIP){
                    config = config +
                        "listen " + appName + "-" + appPort + "\n" +
                        "\tbind 0.0.0.0:" + appPort + "\n" +
                        "\tmode tcp\n" +
                        "\toption tcplog\n" +
                        "\tbalance leastconn\n" +
                        "\tserver " + appName + "-1 " + hostIP + ":" + ip[1] + " check\n"
                }
            }
        }
        fs.writeFileSync('/tmp/haproxy.cfg', config);
    }
}
setInterval(function() {
    request(options,callback);
    exec('/root/haproxy-marathon-bridge refresh_system_haproxy', function (error, stdout, stderr) {
        if (error !== null) {
            console.log('exec error: ' + error);
        }
    });
},1000);
