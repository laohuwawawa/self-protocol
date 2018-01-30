SELFToken = artifacts.require("SELFToken");

contract("SELFToken",function(accounts){
    console.log("--- start of copyright function test ---");

    var self_token;
    var writer = accounts[0];
    var copyright = 0x001;
    var version = 0x002;

    SELFToken.deployed(function(instance){

        self_token = instance;
        console.log("record copyright: " + copyright + " version: " + version);
        return self_token.recordCopyright(accounts[0],copyright,version);

    }).then(function(succee){
        
        console.log("result of recording: " + succee);
        console.log("query copyright: " + self_token);
        return self_token.queryCopyright.call(writer,copyright);

    }).then(function(version){

        console.log("copyright version: " + version);
        
    });
    
});
