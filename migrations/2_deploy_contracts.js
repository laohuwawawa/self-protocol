var SELFToken = artifacts.require("SELFToken");

module.exports = function (deployer) {
    console.log("--- start self token migration ---");
    deployer.deploy(SELFToken);
}