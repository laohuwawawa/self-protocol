var SELFToken = artifacts.require("SELFToken");

contract('SELFToken', function (accounts) {
    console.log("--- start of base token function test ---");

    var self_token;
    var amount = 100;

    SELFToken.deployed().then(function (instance) {

        self_token = instance;
        return self_token.totalSupply.call();

    }).then(function(totalSupply){

        console.log("total supply token " + totalSupply);
        return self_token.balanceOf.call(accounts[0]);

    }).then(function(balance){

        console.log("balance of account1 : " + balance);
        return self_token.balanceOf.call(accounts[1]);

    }).then(function(balance){

        console.log("balance of account2 : " + balance);
        return self_token.balanceOf.call(accounts[2]);

    }).then(function(balance){

        console.log("balance of account3 : " + balance);
        return self_token.getOwner.call();

    }).then(function(owner){

        console.log("contract owner is " + owner);
        console.log("send transation from account1 to account3 : value " + amount);

        return self_token.transfer(accounts[2],amount);

    }).then(function(success){

        console.log("result of transation: " + success);
        return self_token.balanceOf.call(accounts[2]);

    }).then(function(balance){

        console.log("balance of account3 : " + balance);

    });
});