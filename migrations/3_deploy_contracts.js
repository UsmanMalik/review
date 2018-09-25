var ClientContract = artifacts.require("ClientContract");

module.exports = function(deployer) {
  deployer.deploy(ClientContract);
};