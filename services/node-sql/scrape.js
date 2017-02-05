var args= require('system').args;
var webPage = require('webpage');
var page = webPage.create();

if(args.length <3) {
  console.log("USAGE: phantomjs.exe scrapepage.js url sql\n");
  console.log('ie.: phantomjs.exe scrapepage.js "https://news.ycombinator.com/news" "select nodeName,href,innerText from document where className=\'storylink\'"');
  phantom.exit();
}

var url= args[1];
var sql=args[2];

page.open(url, function(status) {
  page.includeJs("https://cdn.jsdelivr.net/g/js-xlsx@0.8.1(xlsx.core.min.js),alasql@0.3.5",function(){
    var result=page.evaluate(function(sql) {
      var response="";
      try {
        alasql("create table document");
        alasql.tables.document.data=[].slice.call(document.all);
        response=alasql(sql);
      } catch(e) {
        response=e.message;
      }
      return response;
    },sql);
    result = (typeof result == 'object') ? JSON.stringify(result,null,2) : result;
    console.log(result);
    phantom.exit();
  });
});
