var SELFToken = artifacts.require("SELFToken");

module.exports = function (deployer) {
    console.log("---start migration self token");
    deployer.deploy(SELFToken);
}