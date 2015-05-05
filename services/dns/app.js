var argv = require('minimist')(process.argv.slice(2));
var fs = require('fs');
var exec = require('child_process').exec;
var is = require('is_js');
if (argv.h || !argv.dns){
    console.log("--dns=<ip1>,<ip2>,<ip3> \nexample: --dns=8.8.8.8,8.8.4.4");
    process.exit(0);
}
if (argv.dns){
    var input = argv.dns;
    input = input.split(',');
    if(input.length < 1){
        console.log("--dns=<ip1>,<ip2>,<ip3> example: --dns=8.8.8.8,8.8.4.4");
        process.exit(0);
    } else {
        var output = [];
        for (var i = 0; i < input.length; i++) {
            if(is.not.ipv4(input[i])){
                console.log("Please input valid IPV4");
                process.exit(0);
            } else {
                output.push('nameserver\t' + input[i]);
            }
        }
        fs.writeFileSync('/etc/resolv.dnsmasq.conf', output.join('\n'));
        exec('dnsmasq',function(error,stdout,stderr){
            if(error){
                console.log(error);
                process.exit(1);
            } else {
                console.log(stdout);
                console.log(stderr);
            }
        });
        setInterval(function(){ console.log('alive') }, 86400000);
    }
}