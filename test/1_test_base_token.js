var SELFToken = artifacts.require("SELFToken");

contract('SELFToken', function (accounts) {
    console.log("--- start of base token function test ---");
    console.log(accounts);

    var self_token;

    SELFToken.deployed().then(function (instance) {

        self_token = instance;
        return self_token.totalSupply.call();

    }).then(function(totalSupply){

        console.log("total supply token " + totalSupply);
        return self_token.balanceOf.call(accounts[0]);

    }).then(function(balance){

        console.log("account 1 balance : " + balance);
        return self_token.balanceOf.call(accounts[1]);

    }).then(function(balance){

        console.log("account 2 balance : " + balance);
        return self_token.getOwner.call();

    }).then(function(owner){

        console.log("contract owner is " + owner);

        console.log("--- end of base token function test ---");

    });
});