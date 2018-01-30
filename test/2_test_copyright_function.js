SELFToken = artifacts.require("SELFToken");

contract("SELFToken",function(accounts){
    console.log("--- start of copyright function test ---");

    var self_token;
    var writer = accounts[0];
    var copyright = 0x8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92;
    var info = "hello world !";

    SELFToken.deployed(function(instance){

        self_token = instance;
        console.log("record copyright: " + copyright + " info: " + info);
        return self_token.recordCopyright(accounts[0],copyright,info);

    }).then(function(succee){
        
        console.log("result of recording: " + succee);
        console.log("query copyright: " + self_token);
        return self_token.queryCopyright.call(writer,copyright);

    }).then(function(info){

        console.log("copyright info: " + info);

    });
    
});
